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

knownErrorStrings = ["Payment does not belong to this user", "Payment attempt already made", "Ticket ineligible for refund", "Ticket not eligible for refund","Duplicate values not allowed"]

@router.put("/payments/pay/{payment_id}", response_model = Payment)
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
                ticket = db.query(Tickets).filter(Tickets.id == ticket_payment.ticket_id).first()
                ticket.status = "failed"
                db.add(ticket)
                ticket_payment.status = "failed"
                ticket_payment.last_modified_date = datetime.now()
                db.add(ticket_payment)
            db.commit()
            raise HTTPException(status_code=400, detail="Payment failed")
        
        #if successful payment, update status of payment item and all ticket_payment items to success
        for ticket_payment in ticket_payments:
            ticket = db.query(Tickets).filter(Tickets.id == ticket_payment.ticket_id).first()
            ticket.status = "active"
            db.add(ticket)
            ticket_payment.status = "success"
            ticket_payment.last_modified_date = datetime.now()
            db.add(ticket_payment)

        payment.status = "success"
        payment.last_modified_date = datetime.now()

        db.commit()
        return payment
    except Exception as e:
        print("Error making payment: "+str(e))

        #If exception does not have status_code or detail properties, return default uninformative error message
        if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
            raise HTTPException(status_code=400, detail="Invalid Request")
        
        #If exception detail is known, return the error details, else return default uninformative error message
        if string_exists_or_ends_with(e.detail, knownErrorStrings):
            raise HTTPException(status_code=e.status_code, detail=e.detail)
        else:
            raise HTTPException(status_code=400, detail= "Invalid Request")
    

@router.put("/payments/refund", response_model=list[Ticket])
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
        #If exception does not have status_code or detail properties, return default uninformative error message
        if hasattr(e, "status_code") == False or hasattr(e, "detail") == False:
            raise HTTPException(status_code=400, detail="Invalid Request")
        
        #If exception detail is known, return the error details, else return default uninformative error message
        if string_exists_or_ends_with(e.detail, knownErrorStrings):
            raise HTTPException(status_code=e.status_code, detail=e.detail)
        else:
            raise HTTPException(status_code=400, detail= "Invalid Request")


    



    
    
    







    

        


