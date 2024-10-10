from sqlalchemy import Column, Integer, String, DateTime, Date, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
import uuid

from app.database import Base


class Users(Base):
    __tablename__ = "Users"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True) #id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)
    phone = Column(String)
    first_name = Column(String)
    last_name = Column(String)
    date_of_registration = Column(DateTime(timezone=True))
    last_modified_date = Column(DateTime(timezone=True))
    password = Column(String)

    tickets = relationship("Tickets", back_populates="user")
    payments = relationship("Payments", back_populates="user")
    refunds = relationship("Refunds", back_populates="user")


class Tickets(Base):
    __tablename__ = "Tickets"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    showing_id = Column(UUID(as_uuid=True), ForeignKey("Showings.id"))
    user_id = Column(UUID(as_uuid=True), ForeignKey("Users.id"))
    seat_id = Column(UUID(as_uuid=True), ForeignKey("Seats.id"))
    purchase_time = Column(DateTime(timezone=True))
    pricex100 = Column(Integer)
    status = Column(String)
    discount_id = Column(UUID(as_uuid=True), ForeignKey("Discounts.id"))

    user = relationship("Users", back_populates="tickets")
    showing = relationship("Showings", back_populates="tickets")
    seat = relationship("Seats", back_populates="tickets")
    discount = relationship("Discounts", back_populates="tickets")
    ticket_payments = relationship("TicketPayments", back_populates="ticket")


class Payments(Base):
    __tablename__ = "Payments"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    payment_method = Column(String)
    payment_time = Column(DateTime(timezone=True))
    status = Column(String)
    user_id = Column(UUID(as_uuid=True), ForeignKey("Users.id"))

    user = relationship("Users", back_populates="payments")
    ticket_payments = relationship("TicketPayments", back_populates="payment")


class Movies(Base):
    __tablename__ = "Movies"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    title = Column(String)
    genre = Column(String)
    duration = Column(Integer)
    release_date = Column(Date)
    last_showing_date = Column(Date)

    showings = relationship("Showings", back_populates="movie")


class Showings(Base):
    __tablename__ = "Showings"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    hall_id = Column(UUID(as_uuid=True), ForeignKey("Halls.id"))
    movie_id = Column(UUID(as_uuid=True), ForeignKey("Movies.id"))
    start_time = Column(DateTime(timezone=True))

    hall = relationship("Halls", back_populates="showings")
    movie = relationship("Movies", back_populates="showings")
    tickets = relationship("Tickets", back_populates="showing")


class Halls(Base):
    __tablename__ = "Halls"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    cinema_id = Column(UUID(as_uuid=True), ForeignKey("Cinemas.id"))
    name = Column(String)
    capacity = Column(Integer)

    cinema = relationship("Cinemas", back_populates="halls")
    showings = relationship("Showings", back_populates="hall")
    seats = relationship("Seats", back_populates="hall")


class Cinemas(Base):
    __tablename__ = "Cinemas"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    name = Column(String)
    address = Column(String)
    phone = Column(String)

    halls = relationship("Halls", back_populates="cinema")


class Seats(Base):
    __tablename__ = "Seats"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    hall_id = Column(UUID(as_uuid=True), ForeignKey("Halls.id"))
    row = Column(String)
    number = Column(Integer)
    type = Column(String)

    hall = relationship("Halls", back_populates="seats")
    tickets = relationship("Tickets", back_populates="seat")


class Refunds(Base):
    __tablename__ = "Refunds"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    refund_time = Column(DateTime(timezone=True))
    reason = Column(String)
    status = Column(String)
    user_id = Column(UUID(as_uuid=True), ForeignKey("Users.id"))

    user = relationship("Users", back_populates="refunds")
    ticket_payment_refunds = relationship("TicketPaymentRefunds", back_populates="refund")


class Discounts(Base):
    __tablename__ = "Discounts"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    code = Column(String)
    type = Column(String)
    amountx100 = Column(Integer)
    percentx100 = Column(Integer)
    valid_from = Column(DateTime(timezone=True))
    valid_to = Column(DateTime(timezone=True))

    tickets = relationship("Tickets", back_populates="discount")


class TicketPayments(Base):
    __tablename__ = "Ticket_Payments"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    ticket_id = Column(UUID(as_uuid=True), ForeignKey("Tickets.id"))
    payment_id = Column(UUID(as_uuid=True), ForeignKey("Payments.id"))
    status = Column(String)
    amountx100 = Column(Integer)

    ticket = relationship("Tickets", back_populates="ticket_payments")
    payment = relationship("Payments", back_populates="ticket_payments")
    ticket_payment_refunds = relationship("TicketPaymentRefunds", back_populates="ticket_payment")
    

class TicketPaymentRefunds(Base):
    __tablename__ = "Ticket_Payment_Refunds"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, index=True)
    ticket_payment_id = Column(UUID(as_uuid=True), ForeignKey("Ticket_Payments.id"))
    amountx100 = Column(Integer)
    status = Column(String)
    refund_id = Column(UUID(as_uuid=True), ForeignKey("Refunds.id"))
    reason = Column(String)

    ticket_payment = relationship("TicketPayments", back_populates="ticket_payment_refunds")
    refund = relationship("Refunds", back_populates="ticket_payment_refunds")


