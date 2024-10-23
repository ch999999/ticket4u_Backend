from fastapi import FastAPI

from app import models, auth, users, tickets, payments, showings, cinemas, refunds, movies
from app.database import SessionLocal, engine

app = FastAPI()

models.Base.metadata.create_all(bind=engine)

app.include_router(auth.router)
app.include_router(users.router)
app.include_router(tickets.router)
app.include_router(payments.router)
app.include_router(showings.router)
app.include_router(cinemas.router)
app.include_router(refunds.router)
app.include_router(movies.router)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

