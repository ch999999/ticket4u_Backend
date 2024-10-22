from datetime import datetime, timedelta, timezone
from uuid import UUID
import uuid
from fastapi import APIRouter, Depends, Path, HTTPException, Body
from app.models import Payments, TicketPayments, Tickets, Showings, Refunds, TicketPaymentRefunds, Cinemas, Movies
from app.schemas import Payment, TicketPayment, Ticket, Cinema, Movie
from app.database import SessionLocal
from typing import Annotated, List
from sqlalchemy.orm import Session
from app.auth import get_current_user
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

knownErrorStrings = ["Not Found"]

@router.get("/movies/all", response_model=Movie)
async def fetch_all_movies(db:db_dependency):
    try:
        movies = db.query(Movies).all()
        if movies is None:
            raise HTTPException(status_code=404, detail="Not Found")
    except Exception as e:
        print("Error fetching Movies: "+ str(e))
        #If exception does not have status_code or detail properties, return default uninformative error message
        if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
            raise HTTPException(status_code=400, detail="Invalid Request")
        
        #If exception detail is known, return the error details, else return default uninformative error message
        if string_exists_or_ends_with(e.detail, knownErrorStrings):
            raise HTTPException(status_code=e.status_code, detail=e.detail)
        else:
            raise HTTPException(status_code=400, detail= "Invalid Request")
    

@router.get("/movies/{movie_id}", response_model=Movie)
async def fetch_movie_by_id(db: db_dependency, movie_id: str):
    try:
        movie = db.query(Movies).filter(Movie.id == movie_id).first()
        if movie is None:
            raise HTTPException(status_code=404, detail="Not Found")
        return movie
    except Exception as e:
        print("Error fetching Movie: "+str(e))
        #If exception does not have status_code or detail properties, return default uninformative error message
        if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
            raise HTTPException(status_code=400, detail="Invalid Request")
        
        #If exception detail is known, return the error details, else return default uninformative error message
        if string_exists_or_ends_with(e.detail, knownErrorStrings):
            raise HTTPException(status_code=e.status_code, detail=e.detail)
        else:
            raise HTTPException(status_code=400, detail= "Invalid Request")
        
