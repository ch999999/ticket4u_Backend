from uuid import UUID
from fastapi import APIRouter, Depends, HTTPException
from app.models import Tickets, Showings, Cinemas, Movies, Halls
from app.schemas import Ticket, Movie
from app.database import SessionLocal
from typing import Annotated
from sqlalchemy.orm import Session
from app.auth import get_current_user
from app.error_handling import handle_exception

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

knownErrorStrings = ["Not Found","Showings not found","Bad request","No tickets found for you for this movie"]

@router.get("/movies/all")
async def fetch_all_movies(db:db_dependency):
    try:
        movies = db.query(Movies).all()
        if movies is None or len(movies) < 1:
            raise HTTPException(status_code=404, detail="Not Found")
        return movies
    except Exception as e:
        print("Error fetching Movies: "+ str(e))
        handle_exception(e, knownErrorStrings)
    

@router.get("/movies/{movie_id}", response_model=Movie)
async def fetch_movie_by_id(db: db_dependency, movie_id: str):
    try:
        movie = db.query(Movies).filter(Movies.id == movie_id).first()
        if movie is None:
            raise HTTPException(status_code=404, detail="Not Found")
        return movie
    except Exception as e:
        print("Error fetching Movie: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/movies/{movie_id}/showings")
async def fetch_movie_showings(db: db_dependency, movie_id: UUID):
    try: 
        movie_showings = db.query(Showings).filter(Showings.movie_id == movie_id).all()
        if movie_showings is None or len(movie_showings) < 1:
            raise HTTPException(status_code=404, detail="Showings not found")
        return movie_showings
    except Exception as e:
        print("Error fetching movie showings: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/movies/{movie_id}/cinemas")
async def fetch_movie_cinemas(db: db_dependency, movie_id: UUID):
    try:
        movie_showings = db.query(Showings).filter(Showings.movie_id == movie_id).all()
        movie_halls = []
        for movie_showing in movie_showings:
            movie_hall = db.query(Halls).filter(Halls.id == movie_showing.hall_id).first()
            if movie_hall is None:
                raise HTTPException(status_code=400, detail = "Bad request")
            movie_halls.append(movie_hall)
        if len(movie_halls) < 1:
            raise HTTPException(status_code=404, detail = "Not found")
        movie_cinemas = []
        for movie_hall in movie_halls:
            movie_cinema = db.query(Cinemas).filter(Cinemas.id == movie_hall.cinema_id).first()
            if movie_cinema is None:
                raise HTTPException(status_code=400, detail = "Bad request")
            movie_cinemas.append(movie_cinema)
        if len(movie_cinemas) < 1:
            raise HTTPException(status_code=404, detail = "Not Found")
        return movie_cinemas
    except Exception as e:
        print("Error fetching movie cinemas: "+str(e))
        handle_exception(e, knownErrorStrings)


#get all tickets belonging to a user for a movie
@router.get("/movies/{showing_id}/tickets", response_model=list[Ticket])
async def get_all_tickets_by_movie(user: user_dependency, db: db_dependency, movie_id: UUID):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
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
        handle_exception(e, knownErrorStrings)
        
        
