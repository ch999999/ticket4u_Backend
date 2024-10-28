from fastapi import APIRouter, Depends, Path, HTTPException
from pydantic import Field
from app.models import Showings, Seats, Halls, Movies, Cinemas, Tickets
from app.database import SessionLocal
from typing import Annotated, Optional
from sqlalchemy.orm import Session
from sqlalchemy import or_
from app.auth import get_current_user
from uuid import UUID
from app.error_handling import handle_exception
from datetime import date

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

knownErrorStrings = ["Showings not found", "Movie not found for this showing","Cinema not found for this showing","Showing not found", "Not found", "Seats not found","No tickets found for this showing"]

@router.get("/showings/all")
async def get_all_showings(db: db_dependency):
    try:
        showings = db.query(Showings).all()
        if showings is None:
            raise HTTPException(status_code=404, detail="Showings not found")
        return showings
    except Exception as e:
        print("Error fetching showings: "+str(e))
        handle_exception(e, knownErrorStrings)

    
@router.get("/showings/{showing_id}")
async def get_show_by_id(db: db_dependency, showing_id: UUID = Path()):
    try:
        showing_result = db.query(Showings).filter(Showings.id==showing_id).all()

        if showing_result is None or len(showing_result) < 1:
            raise HTTPException(status_code=404, detail="Showing not found")
        
        return showing_result
        
    except Exception as e:
        print("Error fetching showing: "+str(e))
        handle_exception(e, knownErrorStrings)
    
@router.get("/showings/{showing_id}/movie")
async def get_showing_movie(db: db_dependency, showing_id: UUID):
    try:
        movie_id = db.query(Showings).filter(Showings.id == showing_id).first().movie_id
        movie_result = db.query(Movies).filter(Movies.id == movie_id).first()
        if movie_result is None:
            raise HTTPException(status_code=404, detail="Movie not found for this showing")
        return movie_result
    except Exception as e:
        print("Error fetching movie: "+str(e))
        handle_exception(e, knownErrorStrings)
    

@router.get("/showings/{showing_id}/cinema")
async def get_showing_cinema(db: db_dependency, showing_id: UUID):
    try:
        hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        cinema_id = db.query(Halls).filter(Halls.id == hall_id).first().cinema_id
        cinema_result = db.query(Cinemas).filter(Cinemas.id == cinema_id).first()
        
        if cinema_result is None:
            raise HTTPException(status_code=404, detail="Cinema not found for this showing")
        return cinema_result
        
    except Exception as e:
        print("Error fetching showing cinema: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/showings/{showing_id}/hall")
async def get_showing_hall(db: db_dependency, showing_id: UUID):
    try:
        hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        hall_result = db.query(Halls).filter(Halls.id == hall_id).first()

        if hall_result is None:
            raise HTTPException(status_code=404, detail="Hall not found")
        return hall_result
    except Exception as e:
        print("Error fetching showing hall: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/showings/{showing_id}/seats")
async def get_all_seats(db: db_dependency, showing_id: UUID):
    try:
        showing_hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        hall_seats = db.query(Seats).filter(Seats.hall_id == showing_hall_id).all()
        if hall_seats is None or len(hall_seats) < 1:
            raise HTTPException(status_code=404, detail = "Seats not found")
        return hall_seats
    except Exception as e:
        print("Error fetching seats: "+str(e))
        handle_exception(e, knownErrorStrings)  


@router.get("/showings/{showing_id}/seats/available")#, response_model=Seat)
async def get_seats_available(db: db_dependency, showing_id: UUID = Path()):
    try:
        showing_hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        seats_hall = db.query(Seats).filter(Seats.hall_id==showing_hall_id).all()
        showing_tickets = db.query(Tickets).filter(Tickets.showing_id == showing_id,or_(Tickets.status.ilike("active"),Tickets.status.ilike("unpaid"))).all()
        seats_available = []

        for seat in seats_hall:
            available = True
            for ticket in showing_tickets:
                if ticket.seat_id == seat.id:
                    available = False
                    break
            if available:
                seats_available.append(seat)
        
        if seats_available is not None and len(seats_available) > 0:
            return seats_available
        raise HTTPException(status_code=404, detail="Seats not found")
    except Exception as e:
        print("Error fetching showing: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/showings/{showing_id}/tickets")
async def get_showing_tickets(db: db_dependency, user: user_dependency, showing_id: UUID):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")

    try:
        showing_tickets = db.query(Tickets).filter(Tickets.showing_id == showing_id, Tickets.user_id == user.get("id")).all()
        if showing_tickets is None or len(showing_tickets) < 1:
            raise HTTPException(status_code=404, detail="No tickets found for this showing")
        return showing_tickets
    except Exception as e:
        print("Error fetching tickets: "+str(e))
        handle_exception(e, knownErrorStrings)


        
            


