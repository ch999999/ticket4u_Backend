from pydantic import BaseModel, EmailStr
from datetime import datetime, date
from typing import Optional
from uuid import UUID

class Token(BaseModel):
    access_token: str
    token_type: str


class UserBase(BaseModel):
    username: str
    email: EmailStr
    phone: str
    first_name: str
    last_name: str


class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: UUID
    date_of_registration: datetime
    last_modified_date: datetime

    class Config:
        from_attributes=True


class TicketBase(BaseModel):
    showing_id: UUID
    user_id: UUID
    seat_id: UUID
    pricex100: int
    status: str
    discount_id: Optional[int] = None


class TicketCreate(TicketBase):
    pass


class Ticket(TicketBase):
    id: UUID
    purchase_time: datetime

    class Config:
        from_attributes = True


class PaymentBase(BaseModel):
    payment_method: str
    status: str
    user_id: UUID


class PaymentCreate(PaymentBase):
    pass


class Payment(PaymentBase):
    id: UUID
    payment_time: datetime

    class Config:
        from_attributes = True


class MovieBase(BaseModel):
    title: str
    genre: str
    duration: int
    release_date: date
    last_showing_date: date


class MovieCreate(MovieBase):
    pass


class Movie(MovieBase):
    id: UUID

    class Config:
        from_attributes = True


class ShowingBase(BaseModel):
    hall_id: UUID
    movie_id: UUID
    start_time: datetime


class ShowingCreate(ShowingBase):
    pass


class Showing(ShowingBase):
    id: UUID

    class Config:
        from_attributes = True


class HallBase(BaseModel):
    cinema_id: UUID
    name: str
    capacity: int


class HallCreate(HallBase):
    pass


class Hall(HallBase):
    id: UUID

    class Config:
        from_attributes = True


class CinemaBase(BaseModel):
    name: str
    address: str
    phone: str


class CinemaCreate(CinemaBase):
    pass


class Cinema(CinemaBase):
    id: UUID

    class Config:
        from_attributes = True


class SeatBase(BaseModel):
    hall_id: UUID
    row: str
    number: int
    type: str


class SeatCreate(SeatBase):
    pass


class Seat(SeatBase):
    id: UUID

    class Config:
        from_attributes = True


class RefundBase(BaseModel):
    reason: str
    status: str
    user_id: UUID


class RefundCreate(RefundBase):
    pass


class Refund(RefundBase):
    id: UUID
    refund_time: datetime

    class Config:
        from_attributes = True


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
    id: UUID

    class Config:
        from_attributes = True


class TicketPaymentBase(BaseModel):
    ticket_id: UUID
    payment_id: UUID
    status: str
    amountx100: int


class TicketPaymentCreate(TicketPaymentBase):
    pass


class TicketPayment(TicketPaymentBase):
    id: UUID

    class Config:
        from_attributes = True


class TicketPaymentRefundBase(BaseModel):
    ticket_payment_id: UUID
    amountx100: int
    status: str
    refund_id: UUID
    reason: str


class TicketPaymentRefundCreate(TicketPaymentRefundBase):
    pass


class TicketPaymentRefund(TicketPaymentRefundBase):
    id: UUID

    class Config:
        from_attributes = True