package com.mihir.bookingApp.dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;

import com.mihir.bookingApp.exception.HotelException;
import com.mihir.bookingApp.exception.RoomException;
import com.mihir.bookingApp.model.Booking;

public class BookingDAO extends DAO {

	// Get bookings - User
	public List<Booking> getUserBooking(long id) throws HotelException {
		try {
			begin();
			Query q = getSession().createQuery("from Booking WHERE user_id LIKE :value");
			q.setString("value", String.valueOf(id));
			List<Booking> bookings = q.list();
			commit();
			return bookings;

		} catch (HibernateException e) {
			rollback();
			throw new HotelException("Something went wrong.", e);
		}
	}

	// Get bookings - Delete/Remove
	public Booking getBooking(long id) throws HotelException {
		try {
			begin();
			Query q = getSession().createQuery("from Booking WHERE id LIKE :value");
			q.setString("value", String.valueOf(id));
			List<Booking> bookings = q.list();
			commit();
			return bookings.get(0);

		} catch (HibernateException e) {
			rollback();
			throw new HotelException("Something went wrong.", e);
		}
	}

	// Get all booking - Home Controller
	public List<Booking> getBooking() throws HotelException {
		try {
			begin();
			Query q = getSession().createQuery("from Booking");
			List<Booking> bookings = q.list();
			commit();
			return bookings;

		} catch (HibernateException e) {
			rollback();
			throw new HotelException("Something went wrong.", e);
		}
	}

	// Save booking
	public void save(Booking book) throws RoomException {
		try {
			begin();
			getSession().save(book);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new RoomException("Something went wrong.", e);
		}
	}

	// Delete booking
	public void delete(Booking booking) throws RoomException {
		try {
			begin();
			getSession().delete(booking);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new RoomException("Something went wrong.", e);
		}

	}

	public List<Object> getPreCheck() throws Exception {
		List<Object> object;
		try {
			SQLQuery query = getSession().createSQLQuery("Select * from room_days_reserved");
			object = query.list();
		} catch (HibernateException e) {
			rollback();
			throw new Exception("Something went wrong.", e);
		}
		return object;
	}

}
