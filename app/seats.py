from fastapi import APIRouter, Depends, Path, HTTPException, Query
from pydantic import Field
from app.models import Showings, Seats, Halls, Movies, Cinemas, Tickets, Seats
from app.database import SessionLocal
from typing import Annotated, Optional
from sqlalchemy.orm import Session
from sqlalchemy import and_, or_, select
from app.auth import get_current_user
from uuid import UUID
from app.error_handling import handle_exception
from datetime import date, datetime, time, timezone

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

knownErrorStrings = ["Seat not found"]

@router.get("/seats/{seat_id}")
async def get_seat_by_id(db: db_dependency, seat_id: UUID = Path()):
    try:
        seat = db.query(Seats).filter(Seats.id == seat_id).first()
        if seat is None:
            raise HTTPException(status_code=404, detail="Seat not found")
        return seat
    except Exception as e:
        print("Error fetching seat: "+str(e))
        handle_exception(e, knownErrorStrings)