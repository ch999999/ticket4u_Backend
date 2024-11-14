from fastapi import APIRouter, Depends, Path, HTTPException, Query
from pydantic import Field
from app.models import Payments, Showings, Seats, Halls, Movies, Cinemas, TicketPayments, Tickets
from app.database import SessionLocal
from typing import Annotated, Optional
from sqlalchemy.orm import Session
from sqlalchemy import and_, or_, select
from app.auth import get_current_user
from uuid import UUID
from app.error_handling import handle_exception
from datetime import date, datetime, time, timedelta, timezone

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
user_dependency = Annotated[dict, Depends(get_current_user)]

knownErrorStrings = ["Showings not found","No showings found for this search criteria", "Movie not found for this showing","Cinema not found for this showing","Showing not found", "Not found", "Seats not found","No tickets found for this showing"]

@router.get("/showings/all")
async def get_all_showings(db: db_dependency):
    try:
        showings = db.query(Showings).filter(Showings.start_time > datetime.now(timezone.utc)).order_by(Showings.start_time).all()
        if showings is None:
            raise HTTPException(status_code=404, detail="Showings not found")
        return showings
    except Exception as e:
        print("Error fetching showings: "+str(e))
        handle_exception(e, knownErrorStrings)

    
@router.get("/showings/{showing_id}")
async def get_show_by_id(db: db_dependency, showing_id: UUID = Path()):
    try:
        showing_result = db.query(Showings).filter(Showings.id==showing_id).first()

        if showing_result is None:
            raise HTTPException(status_code=404, detail="Showing not found")
        showing_hall = db.query(Halls).filter(Halls.id == showing_result.hall_id).first()
        showing_cinema = db.query(Cinemas).filter(Cinemas.id == showing_hall.cinema_id).first()
        showing_dict = showing_result.__dict__
        showing_dict["hall_id"] = showing_hall.id
        showing_dict["hall_name"] = showing_hall.name
        showing_dict["cinema_id"] = showing_cinema.id
        showing_dict["cinema_name"] = showing_cinema.name
        return showing_dict
        
    except Exception as e:
        print("Error fetching showing: "+str(e))
        handle_exception(e, knownErrorStrings)
    
@router.get("/showings/{showing_id}/movie")
async def get_showing_movie(db: db_dependency, showing_id: UUID):
    try:
        movie_id = db.query(Showings).filter(Showings.id == showing_id).first().movie_id
        movie_result = db.query(Movies).filter(Movies.id == movie_id).first()
        if movie_result is None:
            raise HTTPException(status_code=404, detail="Movie not found for this showing")
        return movie_result
    except Exception as e:
        print("Error fetching movie: "+str(e))
        handle_exception(e, knownErrorStrings)
    

@router.get("/showings/{showing_id}/cinema")
async def get_showing_cinema(db: db_dependency, showing_id: UUID):
    try:
        hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        cinema_id = db.query(Halls).filter(Halls.id == hall_id).first().cinema_id
        cinema_result = db.query(Cinemas).filter(Cinemas.id == cinema_id).first()
        
        if cinema_result is None:
            raise HTTPException(status_code=404, detail="Cinema not found for this showing")
        return cinema_result
        
    except Exception as e:
        print("Error fetching showing cinema: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/showings/{showing_id}/hall")
async def get_showing_hall(db: db_dependency, showing_id: UUID):
    try:
        hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        hall_result = db.query(Halls).filter(Halls.id == hall_id).first()

        if hall_result is None:
            raise HTTPException(status_code=404, detail="Hall not found")
        return hall_result
    except Exception as e:
        print("Error fetching showing hall: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/showings/{showing_id}/seats")
async def get_all_seats(db: db_dependency, showing_id: UUID):
    try:
        showing_hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        hall_seats = db.query(Seats).filter(Seats.hall_id == showing_hall_id).order_by(Seats.row).all()
        # if hall_seats is None or len(hall_seats) < 1:
        #     raise HTTPException(status_code=404, detail = "Seats not found")
        return hall_seats
    except Exception as e:
        print("Error fetching seats: "+str(e))
        handle_exception(e, knownErrorStrings)  


@router.get("/showings/{showing_id}/seats/available")#, response_model=Seat)
async def get_seats_available(db: db_dependency, showing_id: UUID = Path()):
    try:
        expired_payments = db.query(Payments).filter(or_(Payments.status.ilike("unpaid"), Payments.status.ilike("retry")), (datetime.now(timezone.utc) > Payments.created_date+timedelta(minutes=11))).all()
        if len(expired_payments) > 0:
            for payment in expired_payments:
                payment.status = 'expired'
                ticket_payments = db.query(TicketPayments).filter(TicketPayments.payment_id==payment.id).all()
                for ticket_payment in ticket_payments:
                    ticket_payment.status = 'expired'
                    ticket = db.query(Tickets).filter(Tickets.id==ticket_payment.ticket_id).first()
                    ticket.status = 'failed'
            db.commit()
        
        showing_hall_id = db.query(Showings).filter(Showings.id == showing_id).first().hall_id
        seats_hall = db.query(Seats).filter(Seats.hall_id==showing_hall_id).all()
        showing_tickets = db.query(Tickets).filter(Tickets.showing_id == showing_id,or_(Tickets.status.ilike("active"),Tickets.status.ilike("unpaid"))).all()
        seats_available = []
        
        for seat in seats_hall:
            available = True
            for ticket in showing_tickets:
                if ticket.seat_id == seat.id:
                    available = False
                    break
            if available:
                seats_available.append(seat)
        return seats_available
        # if seats_available is not None and len(seats_available) > 0:
        #     return seats_available
        # raise HTTPException(status_code=404, detail="Seats not found")
    except Exception as e:
        print("Error fetching showing: "+str(e))
        handle_exception(e, knownErrorStrings)


@router.get("/showings/{showing_id}/tickets")
async def get_showing_tickets(db: db_dependency, user: user_dependency, showing_id: UUID):
    if user is None:
        raise HTTPException(status_code=401, detail="Not Authenticated")

    try:
        showing_tickets = db.query(Tickets).filter(Tickets.showing_id == showing_id, Tickets.user_id == user.get("id")).all()
        # if showing_tickets is None or len(showing_tickets) < 1:
        #     raise HTTPException(status_code=404, detail="No tickets found for this showing")
        return showing_tickets
    except Exception as e:
        print("Error fetching tickets: "+str(e))
        handle_exception(e, knownErrorStrings)

def end_of_day(d: date) -> datetime:
    day_end = datetime.combine(d, time(23, 59, 59))
    return day_end.replace(tzinfo=timezone.utc)

def midnight_of(d: date) -> datetime:
    midnight = datetime.combine(d, time.min)
    return midnight.replace(tzinfo=timezone.utc)

@router.get("/showings/search/")
async def search_showings(db: db_dependency, duration1: int = Query(default=0), duration2: int = Query(default=500), start_date1: date = Query(default=date(1900,1,1), ge=date(1900,1,1), le=date(2200,12,31)), start_date2: date = Query(default=date(2200,12,31), ge=date(1900,1,1), le=date(2200,12,31))):
    try:
        join_results = []
        join_result = db.query(Movies).join(Showings).filter(Showings.start_time > datetime.now(timezone.utc), and_(Movies.duration >= duration1, Movies.duration <= duration2), and_(Showings.start_time >= midnight_of(start_date1), Showings.start_time <= end_of_day(start_date2))).all()
        # if join_result is None or len(join_result) < 1:
        #     raise HTTPException(status_code=404, detail="No showings found for this search criteria")
        for movie in join_result:
            for showing in movie.showings:
                dictResult = {
                      "showing_id": showing.id,
                      "hall_id": showing.hall_id,
                      "movie_id": movie.id,
                      "start_time": showing.start_time,
                      "pricex100": showing.pricex100,
                      "duration": movie.duration,
                      "title": movie.title,
                      "genre": movie.genre,
                      "release_date": movie.release_date,
                      "last_showing_date": movie.last_showing_date 
                     }
                join_results.append(dictResult)
        final_results = []
        for result in join_results:
            if (result['start_time'] >= datetime.now(timezone.utc) and result['duration'] >= duration1 and result['duration'] <= duration2) and (result['start_time'] >= midnight_of(start_date1) and result['start_time'] <= end_of_day(start_date2)):
                final_results.append(result)
        # if final_results is None:
        #     raise HTTPException(status_code=404, detail="No showings found for this search criteria")
        
        for result in final_results:
            cinema_id = db.query(Halls).filter(Halls.id == result['hall_id']).first().cinema_id
            cinema = db.query(Cinemas).filter(Cinemas.id == cinema_id).first()
            movie = db.query(Movies).filter(Movies.id == result["movie_id"]).first()
            result['cinema_name'] = cinema.name
            result['cinema_id'] = cinema.id
            result['image_url'] = movie.image_url

        return final_results
        
    except Exception as e:
        print("Error fetching showings: "+str(e))
        handle_exception(e, knownErrorStrings)


        
            


