from datetime import datetime
from fastapi import APIRouter, Depends, Path, HTTPException
from app.models import Tickets, Payments, TicketPayments, Seats, Showings, Halls
from app.schemas import TicketBase, TicketCreate, Ticket, PaymentCreate, TicketPaymentCreate, Payment
from app.database import SessionLocal
from typing import Annotated
from sqlalchemy.orm import Session
from app.auth import get_current_user
from uuid import UUID

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]


@router.post("/tickets/create", response_model=Payment)
async def create_ticket(user: user_dependency, db: db_dependency, ticket_creates: list[TicketCreate]):
    try:
        if user is None:
            raise HTTPException(status_code=401, detail="Not Authenticated")
        
        #If duplicate seat_ids found, reject
        # if check_duplicate_values(ticket_creates, "seat_id") is True:
        #     raise HTTPException(status_code=400, detail="Duplicate seats not allowed")
        
        #Get list of active and to-be-paid-for tickets for this showing, and get the hall for this showing
        showing_id = ticket_creates[0].showing_id
        showing_tickets = db.query(Tickets).filter(Tickets.showing_id == showing_id and (Tickets.status.lower() == "active" or Tickets.status.lower() == "unpaid")).all()
        showing_hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id

        #Check 1: if different showings found in ticket list, reject
        #Check 2: if seat not found in the hall for the showing, reject
        #Check 3: if seat already booked for this showing, reject
        for ticket_create in ticket_creates:
            ticket_hall_id = db.query(Seats).filter(Seats.id == ticket_create.seat_id).first().hall_id
            if ticket_create.showing_id != showing_id:
                raise HTTPException(status_code=400, detail="Only one showing allowed per ticket(s) creation request")
            if ticket_hall_id != showing_hall_id:
                raise HTTPException(status_code=400, detail="Seat requested doesn't exist in hall of showing requested")         
            for showing_ticket in showing_tickets:
                if ticket_create.seat_id == showing_ticket.seat_id:
                    conflicting_seat = db.query(Seats).filter(Seats.id == ticket_create.seat_id).first()
                    raise HTTPException(status_code=409, detail=f'Seat {conflicting_seat.row+str(conflicting_seat.number)} already taken for this showing.')
            
        #Create new Payment item, status unpaid
        new_payment = Payments(
            payment_method = "tba",
            status = "unpaid",
            user_id = user.get("id"),
            created_date = datetime.now(),
            last_modified_date = datetime.now()
        )
        db.add(new_payment)

        #Create new Ticket item and Ticket_Payment item for every ticket in ticket_creates
        showing = db.query(Showings).filter(Showings.id == showing_id).first()
        for ticket_create in ticket_creates:
            new_ticket = Tickets(
                showing_id = ticket_create.showing_id,
                user_id = user.get("id"),
                seat_id = ticket_create.seat_id,
                pricex100 = showing.pricex100,
                status = "unpaid",
                created_date = datetime.now(),
                last_modified_date = datetime.now()
            )
            db.add(new_ticket)

            new_ticket_payment = TicketPayments(
                ticket_id = new_ticket.id,
                payment_id = new_payment.id,
                status = "unpaid",
                amountx100 = showing.pricex100,
                created_date = datetime.now(),
                last_modified_date = datetime.now()
            )
            db.add(new_ticket_payment)
        
        db.commit()

        #If successful, return the Payment
        return new_payment
    except Exception as e:
        print("Error creating ticket: "+str(e))
        raise HTTPException(status_code=400, detail= "Invalid Request")

def check_duplicate_values(list, key):
    seen = set()
    for d in list:
        if key in d:
            if d[key] in seen:
                return True
            seen.add(d[key])
    return False

@router.get("/tickets/payment_group/{payment_id}", response_model = list[Ticket])
async def get_tickets_by_payment(user: user_dependency, db: db_dependency, payment_id: UUID):
    try:
        if user is None:
            raise HTTPException(status_code=401, detail="Not Authenticated")

        payment = db.query(Payments).filter(Payments.id == payment_id).first()

        if payment.user_id != user.get("id"):
            raise HTTPException(status_code=401, detail="Payment does not belong to this user")
        
        #find and return all tickets associated with the payment
        tickets = []
        ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id == payment_id).all()
        for ticket_payment in ticket_payments:
            ticket = db.query(Tickets).filter(Tickets.id == ticket_payment.ticket_id).first()
            tickets.append(ticket)
        return tickets
    except Exception as e:
        print("Error fetching tickets: "+str(e))
        raise HTTPException(status_code=400, detail= "Invalid Request")


