from datetime import datetime, timedelta, timezone
from uuid import UUID
from fastapi import APIRouter, Depends, HTTPException, Body
from sqlalchemy import desc
from app.models import Payments, TicketPayments, Tickets
from app.schemas import Payment, Ticket
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

knownErrorStrings = ["Payment does not belong to this user","Expired","No successful payments found for this user","Ticket payments not found","Payment not found","Unauthorized","No payments found for this user", "Payment attempt already made", "Ticket ineligible for refund", "Ticket not eligible for refund","Duplicate values not allowed"]

@router.get("/payments/all")
async def get_all_payments(user: user_dependency, db: db_dependency):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        user_payments = db.query(Payments).filter(Payments.user_id == user.get("id")).order_by(desc(Payments.created_date)).all()
        # if user_payments is None or len(user_payments) < 1:
        #     raise HTTPException(status_code=404, detail="No payments found for this user")
        return user_payments
    except Exception as e:
        print("Error fetching payments: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/payments/all/success")
async def get_all_payments(user: user_dependency, db: db_dependency):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    try:
        user_payments = db.query(Payments).filter(Payments.user_id == user.get("id"), Payments.status.ilike("success")).order_by(desc(Payments.created_date)).all()
        # if user_payments is None or len(user_payments) < 1:
        #     raise HTTPException(status_code=404, detail="No successful payments found for this user")
        return user_payments
    except Exception as e:
        print("Error fetching payments: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/payments/{payment_id}")
async def get_payment_by_id(user: user_dependency, db: db_dependency, payment_id: UUID):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        payment = db.query(Payments).filter(Payments.id == payment_id).first()
        if payment is None:
            raise HTTPException(status_code=404, detail="Payment not found")
        if str(payment.user_id) != str(user.get("id")):
            raise HTTPException(status_code=401, detail="Unauthorized")
        
        #if current time > 11 minutes from creation time, update status to expired and reject
        if (payment.status.lower()=="unpaid" or payment.status.lower()=="retry" ) and (datetime.now(timezone.utc) > payment.created_date+timedelta(minutes=11)):
            print(payment.status.lower())
            payment.status = 'expired'
            ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id==payment_id).all()
            for ticket_payment in ticket_payments:
                ticket_payment.status = 'expired'
                ticket = db.query(Tickets).filter(Tickets.id==ticket_payment.ticket_id).first()
                ticket.status = 'failed'
            db.commit()
            payment = db.query(Payments).filter(Payments.id == payment_id).first()
        return payment
    except Exception as e:
        print("Error fetching payment: "+str(e))
        handle_exception(e, knownErrorStrings)

@router.get("/payments/{payment_id}/ticket_payments")
async def fetch_payment_ticket_payments(user: user_dependency, db: db_dependency, payment_id: UUID):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        payment = db.query(Payments).filter(Payments.id == payment_id).first()
        if payment is None:
            raise HTTPException(status_code=404, detail="Payment not found")
        if str(payment.user_id) != str(user.get("id")):
            raise HTTPException(status_code=401, detail="Unauthorized")
        ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id == payment_id).all()
        if ticket_payments is None or len(ticket_payments) < 1:
            raise HTTPException(status_code=404, detail="Ticket payments not found")
        return ticket_payments
    except Exception as e:
        print("Error fetching ticket payments: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/payments/{payment_id}/tickets", response_model = list[Ticket])
async def get_tickets_by_payment(user: user_dependency, db: db_dependency, payment_id: UUID):    
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        payment = db.query(Payments).filter(Payments.id == payment_id).first()

        if str(payment.user_id) != str(user.get("id")):
            raise HTTPException(status_code=401, detail="Payment does not belong to this user")
        
        #find and return all tickets associated with the payment
        tickets = []
        ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id == payment_id).all()
        for ticket_payment in ticket_payments:
            ticket = db.query(Tickets).filter(Tickets.id == ticket_payment.ticket_id).first()
            tickets.append(ticket)
        
        if tickets is None or len(tickets) < 1:
            raise HTTPException(status_code=404, detail="Not found")

        return tickets
    except Exception as e:
        print("Error fetching tickets: "+str(e))
        handle_exception(e, knownErrorStrings)

@router.put("/payments/{payment_id}/pay", response_model = Payment)
async def make_payment(user: user_dependency, db: db_dependency, payment_id: UUID, payment_method: Annotated[str, Body()]):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")

    try:
        success = True
        payment = db.query(Payments).filter(Payments.id == payment_id).first()
        #print(str(payment.user_id) + " "+ str(user.get("id")))
        if str(payment.user_id) != str(user.get("id")):
            raise HTTPException(status_code=401, detail="Payment does not belong to this user")

        #If an attempt, successful or failed has already been attempted, reject
        if payment.status.lower() != "unpaid" and payment.status.lower() != "retry":
            raise HTTPException(status_code=400, detail="Payment attempt already made")

        #if current time > 11 minutes from creation time, update status to expired and reject
        if datetime.now(timezone.utc) > payment.created_date+timedelta(minutes=11):
            payment.status = 'expired'
            ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id==payment_id).all()
            for ticket_payment in ticket_payments:
                ticket_payment.status = 'expired'
                ticket = db.query(Tickets).filter(Tickets.id==ticket_payment.ticket_id).first()
                ticket.status = 'failed'
            db.commit()
            raise HTTPException(status_code=403,detail="Expired")

        ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id == payment_id).all()
        payment.payment_method = payment_method
        #code to make payment
        #pay()
        #if pay() is False success = False

        #if unsuccessful payment, update status of payment item and all ticket_payment items to failed
        if success is not True:
            payment.status = "failed"
            payment.last_modified_date = datetime.now(timezone.utc)
            db.add(payment)
            for ticket_payment in ticket_payments:
                ticket = db.query(Tickets).filter(Tickets.id == ticket_payment.ticket_id).first()
                ticket.status = "failed"
                db.add(ticket)
                ticket_payment.status = "failed"
                ticket_payment.last_modified_date = datetime.now(timezone.utc)
                db.add(ticket_payment)
            db.commit()
            raise HTTPException(status_code=400, detail="Payment failed")
        
        #if successful payment, update status of payment item and all ticket_payment items to success
        for ticket_payment in ticket_payments:
            ticket = db.query(Tickets).filter(Tickets.id == ticket_payment.ticket_id).first()
            ticket.status = "active"
            db.add(ticket)
            ticket_payment.status = "success"
            ticket_payment.last_modified_date = datetime.now(timezone.utc)
            db.add(ticket_payment)

        payment.status = "success"
        payment.last_modified_date = datetime.now(timezone.utc)

        db.commit()
        return payment
    except Exception as e:
        print("Error making payment: "+str(e))
        handle_exception(e, knownErrorStrings)
        
    




    



    
    
    







    

        


