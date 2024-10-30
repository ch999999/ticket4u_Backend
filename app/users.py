from datetime import datetime, timedelta, timezone
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.auth import get_current_user, authenticate_user, create_access_token
from app.models import Users
from app.schemas import User, UserCreate
from app.database import SessionLocal
from typing import Annotated
from passlib.context import CryptContext
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
bcrypt_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

knownErrorStrings = ["Ticket not eligible for refund", "User not found","Successfully created user, but failed to login"]

@router.post("/user/create")
async def create_user(db: db_dependency, user: UserCreate):
    try:
        new_user = Users(
            username=user.username, 
            email=user.email, 
            phone=user.phone, 
            first_name=user.first_name, 
            last_name=user.last_name, 
            password=bcrypt_context.hash(user.password),
            date_of_registration=datetime.now(timezone.utc),
            last_modified_date=datetime.now(timezone.utc)
            )

        db.add(new_user)
        db.commit()
        user_result = db.query(Users).filter(Users.username == new_user.username).first()
        if user_result is None:
            raise HTTPException(status_code=400, detail="Successfully created user, but failed to login")
        access_token = create_access_token(user_result.username, str(user_result.id), timedelta(minutes=30))
        if access_token is None:
            raise HTTPException(status_code=400, detail="Successfully created user, but failed to login")
        return {"access_token": access_token, "token_type": "bearer"}
    except Exception as e:
        print("Error creating user: "+str(e))
        raise HTTPException(status_code= 400, detail= "Invalid Input")
    

@router.get("/user", response_model=User)
async def get_user_by_id(user: user_dependency, db: db_dependency):
    try:
        user_result = db.query(Users).filter(Users.id==user.get("id")).first()
        if str(user_result.id) != str(user.get("id")):
            raise HTTPException(status_code = 401, detail = "Unauthorized")
        if user_result is not None:
            return user_result
        
        raise HTTPException(status_code=404, detail="User not found")
    except Exception as e:
        print("Error fetching user: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.put("/user/edit")
async def edit_user(user: user_dependency,db: db_dependency, user_request: UserCreate, password: str):
    try:
        user_result = authenticate_user(user.get("username"), password, db)
        if user_result is not None:
            user_result.username = user_request.username
            user_result.email = user_request.email
            user_result.phone = user_request.phone
            user_result.first_name = user_request.first_name
            user_result.last_name = user_request.last_name
            user_result.password = bcrypt_context.hash(user_request.password)
            user_result.last_modified_date = datetime.now(timezone.utc)
            db.add(user_result)
            db.commit()
            access_token = create_access_token(user_request.username, str(user_result.id), timedelta(minutes=30))
            return {"access_token": access_token, "token_type": "bearer"}
            
        raise HTTPException(status_code=404, detail="User not found")
    except Exception as e:
        print("Error editing user: "+str(e))
        handle_exception(e, knownErrorStrings)
    
