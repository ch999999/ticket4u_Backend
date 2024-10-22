from datetime import datetime
import uuid
from fastapi import APIRouter, Depends, Path, HTTPException
from sqlalchemy import or_
from app.models import Tickets, Payments, TicketPayments, Seats, Showings, Halls
from app.schemas import TicketBase, TicketCreate, Ticket, PaymentCreate, TicketPaymentCreate, Payment
from app.database import SessionLocal
from typing import Annotated
from sqlalchemy.orm import Session
from app.auth import get_current_user
from uuid import UUID
from app.error_handling import check_duplicate_values, string_exists_or_ends_with

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

knownErrorStrings = ["Duplicate seats not allowed", "Only one showing allowed per ticket(s) creation request",
                     "Seat requested doesn't exist in hall of showing requested", "already taken for this showing",
                     "No tickets found for you for this movie","No tickets found for you for this showing"]

@router.post("/tickets/create", response_model=Payment)
async def create_ticket(user: user_dependency, db: db_dependency, ticket_creates: list[TicketCreate]):
    try:
        if user is None:
            raise HTTPException(status_code=401, detail="Not Authenticated")
        
        dataToCompare = []
        for ticket_create in ticket_creates:
            dataToCompare.append({"seat_id": str(ticket_create.seat_id)})

        #If duplicate seat_ids found, reject
        if check_duplicate_values(dataToCompare, "seat_id"):
            raise HTTPException(status_code=400, detail="Duplicate seats not allowed")
        
        #Get list of active and to-be-paid-for tickets for this showing, and get the hall for this showing
        showing_id = ticket_creates[0].showing_id
        showing_tickets = db.query(Tickets).filter(Tickets.showing_id == showing_id, or_(Tickets.status.ilike("active"), Tickets.status.ilike("unpaid"))).all()
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
                    raise HTTPException(status_code=409, detail=f'Seat {conflicting_seat.row+str(conflicting_seat.number)} already taken for this showing')
            
        #Create new Payment item, status unpaid
        new_payment = Payments(
            id = uuid.uuid4(),
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
                id = uuid.uuid4(),
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

        #If exception does not have status_code or detail properties, return default uninformative error message
        if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
            raise HTTPException(status_code=400, detail="Invalid Request")

        #If exception detail is known, return the error details, else return default uninformative error message
        if string_exists_or_ends_with(e.detail, knownErrorStrings):
            raise HTTPException(status_code=e.status_code, detail=e.detail)
        else:
            raise HTTPException(status_code=400, detail= "Invalid Request")




    
#get all tickets belonging to a user
@router.get("/tickets", response_model=list[Ticket])
async def get_all_tickets_by_user(user: user_dependency, db: db_dependency):
    try:
        if user is None:
            raise HTTPException(status_code=401, detail="Not Authenticated")
        
        user_tickets = db.query(Tickets).filter(Tickets.user_id == user.get("id")).all()
        return user_tickets
    except Exception as e:
        print("Error fetching tickets: "+str(e))
        raise HTTPException(status_code=400, detail="Invalid Request")
    

#get all tickets belonging to a user for a movie
@router.get("/tickets/movie/{movie_id}", response_model=list[Ticket])
async def get_all_tickets_by_movie(user: user_dependency, db: db_dependency, movie_id: UUID):
    try:
        if user is None:
            raise HTTPException(status_code=401, detail="Not Authenticated")
        
        user_tickets = []
        movie_showings = db.query(Showings).filter(Showings.movie_id == movie_id).all()
        
        for movie_showing in movie_showings:
            tickets = db.query(Tickets).filter(Tickets.showing_id == movie_showing.id, Tickets.user_id == user.get("id")).all()
            for ticket in tickets:
                user_tickets.append(ticket)
        
        if user_tickets is None or len(user_tickets) < 1:
            raise HTTPException(status_code=404, detail="No tickets found for you for this movie")
        
        return user_tickets
    except Exception as e:
        print("Error fetching tickets: "+str(e))

        #If exception does not have status_code or detail properties, return default uninformative error message
        if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
            raise HTTPException(status_code=400, detail="Invalid Request")

        #If exception detail is known, return the error details, else return default uninformative error message
        if string_exists_or_ends_with(e.detail, knownErrorStrings):
            raise HTTPException(status_code=e.status_code, detail=e.detail)
        else:
            raise HTTPException(status_code=400, detail= "Invalid Request")
        

#get all tickets belonging to a user for a showing
@router.get("/tickets/showing/{showing_id}", response_model=list[Ticket])
async def get_all_tickets_by_showing(user: user_dependency, db: db_dependency, showing_id: UUID):
    try:
        if user is None:
            raise HTTPException(status_code=401, detail="Not Authenticated")
        
        user_tickets = db.query(Tickets).filter(Tickets.showing_id == showing_id, Tickets.user_id == user.get("id")).all()

        if user_tickets is None or len(user_tickets) < 1:
            raise HTTPException(status_code=404, detail="No tickets found for you for this showing")
        
        return user_tickets
        
    except Exception as e:
        print("Error fetching tickets: "+str(e))

        #If exception does not have status_code or detail properties, return default uninformative error message
        if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
            raise HTTPException(status_code=400, detail="Invalid Request")

        #If exception detail is known, return the error details, else return default uninformative error message
        if string_exists_or_ends_with(e.detail, knownErrorStrings):
            raise HTTPException(status_code=e.status_code, detail=e.detail)
        else:
            raise HTTPException(status_code=400, detail= "Invalid Request")
        



