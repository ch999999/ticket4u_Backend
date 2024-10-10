from datetime import datetime
from uuid import UUID
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.auth import get_current_user
from app.models import Users
from app.schemas import User, UserCreate
from app.database import SessionLocal
from typing import Annotated
from passlib.context import CryptContext


router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]
bcrypt_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@router.post("/user/create", response_model=User)
async def create_user(db: db_dependency, user: UserCreate):
    try:
        new_user = Users(
            username=user.username, 
            email=user.email, 
            phone=user.phone, 
            first_name=user.first_name, 
            last_name=user.last_name, 
            password=bcrypt_context.hash(user.password),
            date_of_registration=datetime.now(),
            last_modified_date=datetime.now()
            )

        db.add(new_user)
        db.commit()
        return new_user
    except Exception as e:
        print("Error creating user: "+str(e))
        raise HTTPException(status_code= 400, detail= "Invalid Input.")
    

@router.get("/user", response_model=User)
async def get_user_by_id(user: user_dependency, db: db_dependency):
    try:
        user_result = db.query(Users).filter(Users.id==user.get("id")).first()
        if user_result is not None:
            return user_result
        
        raise HTTPException(status_code=404, detail="User not found")
    except Exception as e:
        print("Error fetching user: "+str(e))
        raise HTTPException(status_code= 400, detail= "Invalid Request.")
    
