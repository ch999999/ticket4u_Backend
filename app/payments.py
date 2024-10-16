from datetime import datetime
from uuid import UUID
from fastapi import APIRouter, Depends, Path, HTTPException, Body
from app.models import Payments, TicketPayments
from app.schemas import Payment, TicketPayment
from app.database import SessionLocal
from typing import Annotated
from sqlalchemy.orm import Session
from app.auth import get_current_user

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

@router.put("/payments/pay/{payment_id}", response_model = Payment)
async def make_payment(user: user_dependency, db: db_dependency, payment_id: UUID, payment_method: Annotated[str, Body()]):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")

    success = True
    payment = db.query(Payments).filter(Payments.id == payment_id).first()

    if payment.user_id != user.get("id"):
        raise HTTPException(status_code=401, detail="Payment does not belong to this user")

    #If an attempt, successful or failed has already been attempted, reject
    if payment.status.lower() != "unpaid" and payment.status.lower() != "retry":
        raise HTTPException(status_code=400, detail="Payment attempt already made")

    ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id == payment_id).all()
    payment.payment_method = payment_method
    #code to make payment
    #pay()
    #if pay() is False success = False

    #if unsuccessful payment, update status of payment item and all ticket_payment items to failed
    if success is not True:
        payment.status = "failed"
        payment.last_modified_date = datetime.now()
        db.add(payment)
        for ticket_payment in ticket_payments:
            ticket_payment.status = "failed"
            ticket_payment.last_modified_date = datetime.now()
            db.add(ticket_payment)
        db.commit()
        raise HTTPException(status_code=400, detail="Payment failed")
    
    #if successful payment, update status of payment item and all ticket_payment items to success
    for ticket_payment in ticket_payments:
        ticket_payment.status = "success"
        ticket_payment.last_modified_date = datetime.now()
        db.add(ticket_payment)

    payment.status = "success"
    payment.last_modified_date = datetime.now()

    db.commit()
    return payment






    

        


