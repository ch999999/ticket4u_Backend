from datetime import datetime
from fastapi import APIRouter, Depends, Path, HTTPException
from app.models import Tickets, Payments, TicketPayments, Seats, Showings, Halls
from app.schemas import TicketBase, TicketCreate, Ticket, PaymentCreate, TicketPaymentCreate
from app.database import SessionLocal
from typing import Annotated
from sqlalchemy.orm import Session
from app.auth import get_current_user

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]


@router.post("/tickets/create", response_model=list[Ticket])
async def create_ticket(user: user_dependency, db: db_dependency, ticket_creates: list[TicketCreate], payment: PaymentCreate):
    try:
        tickets_created = []
        if user is None:
            raise HTTPException(status_code=401, detail="Not Authenticated")
        
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
            payment_method = payment.payment_method,
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

            tickets_created.append(new_ticket)
        
        db.commit()
        return tickets_created
    except Exception as e:
        print("Error creating ticket: "+str(e))
        raise HTTPException(status_code=400, detail= "Invalid Request")

