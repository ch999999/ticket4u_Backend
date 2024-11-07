from fastapi import FastAPI, APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from fastapi.middleware.cors import CORSMiddleware

from app import models, auth, users, tickets, payments, showings, cinemas, refunds, movies, seats
from app.database import SessionLocal, engine

app = FastAPI()

origins = [
    "http://localhost:3000",
    "http://localhost:3001"
]


# Add CORS middleware to FastAPI app
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

models.Base.metadata.create_all(bind=engine)

app.include_router(auth.router)
app.include_router(users.router)
app.include_router(tickets.router)
app.include_router(payments.router)
app.include_router(showings.router)
app.include_router(cinemas.router)
app.include_router(refunds.router)
app.include_router(movies.router)
app.include_router(seats.router)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

