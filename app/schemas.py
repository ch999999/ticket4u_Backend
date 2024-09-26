from pydantic import BaseModel
from datetime import datetime, date
from typing import List, Optional

class UserBase(BaseModel):
    username: str
    email: str
    phone: Optional[str] = None
    first_name: Optional[str] = None
    last_name: Optional[str] = None

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int
    date_of_registration: datetime
    last_modified_date: datetime

    class Config:
        orm_mode = True

class TicketBase(BaseModel):
    showing_id: int
    seat_id: int
    pricex100: int
    status: str
    discount_id: Optional[int] = None

class TicketCreate(TicketBase):
    pass

class Ticket(TicketBase):
    id: int
    user_id: int
    purchase_time: datetime

    class Config:
        orm_mode = True

class PaymentBase(BaseModel):
    ticket_id: int
    amountx100: int
    payment_method: str
    status: str

class PaymentCreate(PaymentBase):
    pass

class Payment(PaymentBase):
    id: int
    user_id: int
    payment_time: datetime

    class Config:
        orm_mode = True

class MovieBase(BaseModel):
    title: str
    genre: str
    duration: int
    release_date: date
    last_showing_date: date

class MovieCreate(MovieBase):
    pass

class Movie(MovieBase):
    id: int

    class Config:
        orm_mode = True

class ShowingBase(BaseModel):
    hall_id: int
    movie_id: int
    start_time: datetime

class ShowingCreate(ShowingBase):
    pass

class Showing(ShowingBase):
    id: int

    class Config:
        orm_mode = True

class HallBase(BaseModel):
    cinema_id: int
    name: str
    capacity: int

class HallCreate(HallBase):
    pass

class Hall(HallBase):
    id: int

    class Config:
        orm_mode = True

class CinemaBase(BaseModel):
    name: str
    address: str
    phone: str

class CinemaCreate(CinemaBase):
    pass

class Cinema(CinemaBase):
    id: int

    class Config:
        orm_mode = True

class SeatBase(BaseModel):
    hall_id: int
    row: str
    number: int
    type: str

class SeatCreate(SeatBase):
    pass

class Seat(SeatBase):
    id: int

    class Config:
        orm_mode = True

class RefundBase(BaseModel):
    ticket_id: int
    amountx100: int
    reason: str
    status: str
    payment_id: int

class RefundCreate(RefundBase):
    pass

class Refund(RefundBase):
    id: int
    user_id: int
    refund_time: datetime

    class Config:
        orm_mode = True

class DiscountBase(BaseModel):
    code: str
    type: str
    amountx100: Optional[int] = None
    percentx100: Optional[int] = None
    valid_from: datetime
    valid_to: datetime

class DiscountCreate(DiscountBase):
    pass

class Discount(DiscountBase):
    id: int

    class Config:
        orm_mode = True