from sqlalchemy import Column, Integer, String, DateTime, Date, ForeignKey
from sqlalchemy.orm import relationship

from app.database import Base


class User(Base):
    __tablename__ = "Users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String)
    email = Column(String)
    phone = Column(String)
    first_name = Column(String)
    last_name = Column(String)
    date_of_registration = Column(DateTime(timezone=True))
    last_modified_date = Column(DateTime(timezone=True))
    password = Column(String)

    tickets = relationship("Ticket", back_populates="user")
    payments = relationship("Payment", back_populates="user")
    refunds = relationship("Refund", back_populates="user")


class Ticket(Base):
    __tablename__ = "Tickets"

    id = Column(Integer, primary_key=True, index=True)
    showing_id = Column(Integer, ForeignKey("Showings.id"))
    user_id = Column(Integer, ForeignKey("Users.id"))
    seat_id = Column(Integer, ForeignKey("Seats.id"))
    purchase_time = Column(DateTime(timezone=True))
    pricex100 = Column(Integer)
    status = Column(String)
    discount_id = Column(Integer, ForeignKey("Discounts.id"))

    user = relationship("User", back_populates="tickets")
    showing = relationship("Showing", back_populates="tickets")
    seat = relationship("Seat", back_populates="tickets")
    discount = relationship("Discount", back_populates="tickets")
    ticket_payments = relationship("TicketPayment", back_populates="ticket")


class Payment(Base):
    __tablename__ = "Payments"

    id = Column(Integer, primary_key=True, index=True)
    payment_method = Column(String)
    payment_time = Column(DateTime(timezone=True))
    status = Column(String)
    user_id = Column(Integer, ForeignKey("Users.id"))

    user = relationship("User", back_populates="payments")
    ticket_payments = relationship("TicketPayment", back_populates="payment")


class Movie(Base):
    __tablename__ = "Movies"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    genre = Column(String)
    duration = Column(Integer)
    release_date = Column(Date)
    last_showing_date = Column(Date)

    showings = relationship("Showing", back_populates="movie")


class Showing(Base):
    __tablename__ = "Showings"

    id = Column(Integer, primary_key=True, index=True)
    hall_id = Column(Integer, ForeignKey("Halls.id"))
    movie_id = Column(Integer, ForeignKey("Movies.id"))
    start_time = Column(DateTime(timezone=True))

    hall = relationship("Hall", back_populates="showings")
    movie = relationship("Movie", back_populates="showings")
    tickets = relationship("Ticket", back_populates="showing")


class Hall(Base):
    __tablename__ = "Halls"

    id = Column(Integer, primary_key=True, index=True)
    cinema_id = Column(Integer, ForeignKey("Cinemas.id"))
    name = Column(String)
    capacity = Column(Integer)

    cinema = relationship("Cinema", back_populates="halls")
    showings = relationship("Showing", back_populates="hall")
    seats = relationship("Seat", back_populates="hall")


class Cinema(Base):
    __tablename__ = "Cinemas"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    address = Column(String)
    phone = Column(String)

    halls = relationship("Hall", back_populates="cinema")


class Seat(Base):
    __tablename__ = "Seats"

    id = Column(Integer, primary_key=True, index=True)
    hall_id = Column(Integer, ForeignKey("Halls.id"))
    row = Column(String)
    number = Column(Integer)
    type = Column(String)

    hall = relationship("Hall", back_populates="seats")
    tickets = relationship("Ticket", back_populates="seat")


class Refund(Base):
    __tablename__ = "Refunds"

    id = Column(Integer, primary_key=True, index=True)
    refund_time = Column(DateTime(timezone=True))
    reason = Column(String)
    status = Column(String)
    user_id = Column(Integer, ForeignKey("Users.id"))

    user = relationship("User", back_populates="refunds")
    ticket_payment_refunds = relationship("TicketPaymentRefund", back_populates="refund")


class Discount(Base):
    __tablename__ = "Discounts"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String)
    type = Column(String)
    amountx100 = Column(Integer)
    percentx100 = Column(Integer)
    valid_from = Column(DateTime(timezone=True))
    valid_to = Column(DateTime(timezone=True))

    tickets = relationship("Ticket", back_populates="discount")


class TicketPayment(Base):
    __tablename__ = "Ticket_Payments"

    id = Column(Integer, primary_key=True, index=True)
    ticket_id = Column(Integer, ForeignKey("Tickets.id"))
    payment_id = Column(Integer, ForeignKey("Payments.id"))
    status = Column(String)
    amountx100 = Column(Integer)

    ticket = relationship("Ticket", back_populates="ticket_payments")
    payment = relationship("Payment", back_populates="ticket_payments")
    ticket_payment_refunds = relationship("TicketPaymentRefund", back_populates="ticket_payment")
    

class TicketPaymentRefund(Base):
    __tablename__ = "Ticket_Payment_Refunds"

    id = Column(Integer, primary_key=True, index=True)
    ticket_payment_id = Column(Integer, ForeignKey("Ticket_Payments.id"))
    amountx100 = Column(Integer)
    status = Column(String)
    refund_id = Column(Integer, ForeignKey("Refunds.id"))
    reason = Column(String)

    ticket_payment = relationship("TicketPayment", back_populates="ticket_payment_refunds")
    refund = relationship("Refund", back_populates="ticket_payment_refunds")


