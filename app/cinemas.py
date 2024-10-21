from datetime import datetime, timedelta, timezone
from uuid import UUID
import uuid
from fastapi import APIRouter, Depends, Path, HTTPException, Body
from app.models import Payments, TicketPayments, Tickets, Showings, Refunds, TicketPaymentRefunds
from app.schemas import Payment, TicketPayment, Ticket
from app.database import SessionLocal
from typing import Annotated, List
from sqlalchemy.orm import Session
from app.auth import get_current_user
from app.error_checking import check_duplicate_values, string_exists_or_ends_with

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]