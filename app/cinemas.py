from uuid import UUID
from fastapi import APIRouter, Depends, HTTPException
from app.models import Showings, Cinemas, Halls, Movies
from app.schemas import Cinema
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

knownErrorStrings = ["Not Found","No movies found for this cinema","No showings found for this cinema"]

@router.get("/cinemas/all")
async def fetch_all_cinemas(db:db_dependency):
    try:
        cinemas = db.query(Cinemas).all()
        if cinemas is None or len(cinemas) < 1:
            raise HTTPException(status_code=404, detail="Not Found")
        return cinemas
    except Exception as e:
        print("Error fetching Cinemas: "+ str(e))
        handle_exception(e, knownErrorStrings)
    

@router.get("/cinemas/{cinema_id}", response_model=Cinema)
async def fetch_cinema_by_id(db: db_dependency, cinema_id: UUID):
    try:
        cinema = db.query(Cinemas).filter(Cinemas.id == cinema_id).first()
        if cinema is None:
            raise HTTPException(status_code=404, detail="Not Found")
        return cinema
    except Exception as e:
        print("Error fetching Cinema: "+str(e))
        handle_exception(e, knownErrorStrings)

@router.get("/cinemas/{cinema_id}/showings")
async def fetch_cinema_showings(db: db_dependency, cinema_id: UUID):
    try:
        cinema_halls = db.query(Halls).filter(Halls.cinema_id == cinema_id).all()
        if cinema_halls is None or len(cinema_halls) < 1:
            raise HTTPException(status_code=404, detail="Not found")
        cinema_showings = []
        for cinema_hall in cinema_halls:
            cinema_showing = db.query(Showings).filter(Showings.hall_id == cinema_hall.id).first()
            if cinema_showing is None:
                raise HTTPException(status_code=404, detail="Not found")
            cinema_showings.append(cinema_showing)
        if len(cinema_showings) < 1:
            raise HTTPException(status_code=404, detail = "No showings found for this cinema")
        return cinema_showings
    except Exception as e:
        print("Error fetching cinema showings: "+str(e))
        handle_exception(e, knownErrorStrings)

@router.get("/cinemas/{cinema_id}/halls")
async def fetch_cinema_halls(db: db_dependency, cinema_id: UUID):
    try:
        cinema_halls = db.query(Halls).filter(Halls.cinema_id == cinema_id).all()
        if cinema_halls is None or len(cinema_halls) < 1:
            raise HTTPException(status_code=404, detail="Not found")
        return cinema_halls
    except Exception as e:
        print("Error fetching cinema halls: "+str(e))
        handle_exception(e, knownErrorStrings)

@router.get("/cinemas/{cinema_id}/movies")
async def fetch_cinema_movies(db: db_dependency, cinema_id: UUID):
    try:
        cinema_halls = db.query(Halls).filter(Halls.cinema_id == cinema_id).all()
        if cinema_halls is None or len(cinema_halls) < 1:
            raise HTTPException(status_code=404, detail="Not found")
        cinema_showings = []
        for cinema_hall in cinema_halls:
            cinema_showing = db.query(Showings).filter(Showings.hall_id == cinema_hall.id).first()
            if cinema_showing is None:
                raise HTTPException(status_code=404, detail="Not found")
            cinema_showings.append(cinema_showing)
        
        cinema_movies  = []
        for cinema_showing in cinema_showings:
            cinema_movie = db.query(Movies).filter(Movies.id == cinema_showing.movie_id).first()
            if cinema_movie is None:
                raise HTTPException(status_code=404, detail="Not found")
            cinema_movies.append(cinema_movie)
        
        if len(cinema_movies) < 1:
            raise HTTPException(status_code=404, detail = "No movies found for this cinema")
        return cinema_movies
    except Exception as e:
        print("Error fetching cinema movies: "+ str(e))
        handle_exception(e, knownErrorStrings)



            
        
        
