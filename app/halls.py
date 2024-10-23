from datetime import datetime, timedelta, timezone
from uuid import UUID
import uuid
from fastapi import APIRouter, Depends, Path, HTTPException, Body
from app.models import Payments, TicketPayments, Tickets, Showings, Refunds, TicketPaymentRefunds, Cinemas, Movies, Halls, Seats
from app.schemas import Payment, TicketPayment, Ticket, Cinema, Movie
from app.database import SessionLocal
from typing import Annotated, List
from sqlalchemy.orm import Session
from app.auth import get_current_user
from app.error_handling import check_duplicate_values, string_exists_or_ends_with, handle_exception

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

knownErrorStrings = ["Not Found","Seats not found", "Halls not found"]

@router.get("/halls/{hall_id}")
async def get_hall_by_id(db: db_dependency, hall_id: UUID = Path()):
    try:
        hall_result = db.query(Halls).filter(Halls.id==hall_id).first()

        if hall_result is not None:
            return hall_result
        raise HTTPException(status_code=404, detail="Halls not found")
    except Exception as e:
        print("Error fetching showing: "+str(e))
        handle_exception(e, knownErrorStrings)
    
@router.get("/halls/{hall_id}/seats")
async def get_seats_by_hallid(db: db_dependency, hall_id: UUID = Path()):
    try:
        hall_seats = db.query(Seats).filter(Seats.hall_id==hall_id).all()

        if hall_seats is not None and len(hall_seats) > 1:
            return hall_seats
        raise HTTPException(status_code=404, detail="Seats not found")
    except Exception as e:
        print("Error fetching showing: "+str(e))
        handle_exception(e, knownErrorStrings)