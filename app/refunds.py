from datetime import datetime, timezone
from uuid import UUID
import uuid
from fastapi import APIRouter, Depends, HTTPException, Body
from app.models import TicketPayments, Tickets, Refunds, TicketPaymentRefunds
from app.schemas import Ticket
from app.database import SessionLocal
from typing import Annotated, List
from sqlalchemy.orm import Session
from app.auth import get_current_user
from app.error_handling import check_duplicate_values, handle_exception

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

knownErrorStrings = ["Refunds not found","Unauthorized","Not found","Ticket ineligible for refund","Duplicate values not allowed","Ticket not eligible for refund"]

@router.get("/refunds/all")
async def fetch_all_refunds(db: db_dependency, user: user_dependency):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        user_refunds = db.query(Refunds).filter(Refunds.user_id == user.get("id")).all()
        if user_refunds is None or len(user_refunds) < 1:
            raise HTTPException(status_code=404, detail="Refunds not found")
        return user_refunds
    except Exception as e:
        print("Error fetching refunds: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/refunds/{refund_id}")
async def fetch_refund_by_id(db: db_dependency, user: user_dependency, refund_id: UUID):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        refund = db.query(Refunds).filter(Refunds.id == refund_id).first()
        if refund is None:
            raise HTTPException(status_code=404, detail="Not found")
        if str(refund.user_id) != str(user.get("id")):
            raise HTTPException(status_code=401, detail = "Unauthorized")
        
        return refund
    except Exception as e:
        print("Error fetching refund: "+str(e))
        handle_exception(e, knownErrorStrings)

@router.get("/refunds/{refund_id}/ticket_payment_refunds")
async def fetch_ticket_payment_refunds(user: user_dependency, db: db_dependency, refund_id: UUID):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        refund = db.query(Refunds).filter(Refunds.id == refund_id).first()
        if refund is None:
            raise HTTPException(status_code=404, detail="Not found")
        if str(refund.user_id) != str(user.get("id")):
            raise HTTPException(status_code=401, detail = "Unauthorized")
        ticket_payment_refunds = db.query(TicketPaymentRefunds).filter(TicketPaymentRefunds.refund_id == refund_id).all()
        if ticket_payment_refunds is None or len(ticket_payment_refunds) < 1:
            raise HTTPException(status_code=404, detail = "Not found")
        return ticket_payment_refunds
    except Exception as e:
        print("Error fetching ticket payment refunds: "+str(e))
        handle_exception(e, knownErrorStrings)
    

@router.post("/refund/refund_tickets", response_model=list[Ticket])
async def refund_tickets(user: user_dependency, db: db_dependency, ticket_ids: Annotated[List[UUID], Body()]):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")
    
    try:
        #extract the ticket_payments from database
        ticket_payments_to_refund = []
        dataToCompare = []
        for id in ticket_ids:
            dataToCompare.append({"id": str(id)})
            ticket_payment = db.query(TicketPayments).filter(TicketPayments.ticket_id == id).first()
            #if status of any is found to not be paid, cannot refund, strange request, terminate operation
            if ticket_payment.status.lower() != "success":
                raise HTTPException(status_code=400, detail="Ticket ineligible for refund")
            ticket_payments_to_refund.append(ticket_payment)
        
        #if array still empty, reject
        if len(ticket_payments_to_refund) < 1:
            raise HTTPException(status_code=404, detail="Not found")

        #if duplicate ids found, reject
        if check_duplicate_values(dataToCompare, "id"):
            raise HTTPException(status_code=400, detail="Duplicate values not allowed")

        #Create Refund Item
        refund = Refunds(
            id = uuid.uuid4(),
            status = "pending",
            user_id = user.get("id"),
            created_date = datetime.now(timezone.utc),
            last_modified_date = datetime.now(timezone.utc)
        )
        db.add(refund)

        refunded_tickets = []
        #Create Ticket_Payment_Refund items and update Ticket_payment status to refunded
        for ticket_payment in ticket_payments_to_refund:
            #check again if status of ticket payment is 'success'. Only refund if 'success'
            if ticket_payment.status.lower() != "success":
                raise HTTPException(status_code=400, detail="Ticket not eligible for refund")
            
            #code to refund to customer bank/e-wallet etc
            #refund()

            #create ticket_payment_refund items
            ticket_payment_refund = TicketPaymentRefunds(
                ticket_payment_id = ticket_payment.id,
                amountx100 = ticket_payment.amountx100,
                status = "success",
                reason = "customer request",
                refund_id = refund.id,
                created_date = datetime.now(timezone.utc),
                last_modified_date = datetime.now(timezone.utc)
            )
            db.add(ticket_payment_refund)

            #update ticket_payment status
            ticket_payment.status = "refunded"
            db.add(ticket_payment)

            #update ticket status
            ticket_to_update = db.query(Tickets).filter(Tickets.id == ticket_payment.ticket_id).first()
            ticket_to_update.status = "cancelled"
            db.add(ticket_to_update)
            refunded_tickets.append(ticket_to_update)
        
        refund.status = "success"
        db.add(refund)

        db.commit()
        return refunded_tickets
    except Exception as e:
        print("Error refunding: "+str(e))
        handle_exception(e, knownErrorStrings)


