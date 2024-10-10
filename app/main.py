from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session

from app import crud, models, schemas, auth, users
from app.database import SessionLocal, engine

app = FastAPI()

models.Base.metadata.create_all(bind=engine)

app.include_router(auth.router)
app.include_router(users.router)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

