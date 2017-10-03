package com.mihir.bookingApp.dao;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.validation.BindingResult;

import com.mihir.bookingApp.exception.RoomException;
import com.mihir.bookingApp.model.Booking;
import com.mihir.bookingApp.model.Hotel;
import com.mihir.bookingApp.model.Room;
import com.mihir.bookingApp.model.RoomType;

public class RoomDAO extends DAO {

	public List<RoomType> getRoomTypes() throws RoomException {
		try {
			begin();
			Query q = getSession().createQuery("from RoomType");
			List<RoomType> roomType = q.list();
			commit();
			return roomType;

		} catch (HibernateException e) {
			rollback();
			throw new RoomException("Cannot find room type");
		}
	}

	public RoomType getRoomType(long id) throws RoomException {
		try {
			begin();
			Query q = getSession().createQuery("from RoomType WHERE id LIKE :value");
			q.setLong("value", id);
			RoomType roomType = (RoomType) q.uniqueResult();
			commit();
			return roomType;

		} catch (HibernateException e) {
			rollback();
			throw new RoomException("Cannot find room type");
		}
	}

	public void save(Room room) throws RoomException {
		try {
			System.out.println("reached to save a room");
			begin();
			getSession().save(room);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new RoomException("Room not saved", e);
		}
	}

	public boolean validateRoomNumber(Room room) {
		boolean flag = false;
		Criteria roomCriteria = getSession().createCriteria(Room.class);
		roomCriteria.add(Restrictions.eq("room_number", room.getRoom_number()));
		Criteria hotelCriteria = roomCriteria.createCriteria("hotel");
		hotelCriteria.add(Restrictions.eq("id", room.getHotel().getId()));
		List<Room> rooms = roomCriteria.list();
		if (rooms.size() > 0) {
			flag = true;
		}
		return flag;
	}

	public Map<String, String> validateRoom(Room room, Map<String, String> messages) {
		String floor_number = String.valueOf(room.getFloor());
		String room_number = String.valueOf(room.getRoom_number());
		String price = String.valueOf(room.getPrice());

		if (floor_number.equals("0") || !floor_number.matches("^[0-9]*")) {
			messages.put("title", "Please enter valid Floor number");
		}
		if (room_number.equals("") || !room_number.matches("^[0-9]*")) {
			messages.put("actor", "Please enter valid Room Number");
		} else if (validateRoomNumber(room)) {
			messages.put("actor", "Room number already exists");
		}
		if (price.equals("0") || !price.matches("^[0-9]*")) {
			messages.put("actress", "Please enter valid Price");
		}
		return messages;

	}

	public List<Room> getRoomAvailable(List<Hotel> hotelList, List<Date> dateRange, List<Room> roomAvailable,
			int numberRooms, RoomType rt) {
		for (Hotel hotel : hotelList) {
			Map<Long, Room> rooms = hotel.getRooms();
			int counter = 0;
			Room current = null;
			for (Entry<Long, Room> room : rooms.entrySet()) {
				Room r = room.getValue();
				Map<Date, Long> roomBooking = r.getDays_reserved();
				boolean found = false;
				Iterator<Date> itDates = dateRange.iterator();

				while (itDates.hasNext()) {
					Date day = itDates.next();
					if (roomBooking.get(day) != null) {
						found = true;
						break;
					}
				}
				if (!found && r.getType().getDescription().equals(rt.getDescription())) {
					counter++;
					current = r;
				}
			}
			if (counter >= numberRooms)
				roomAvailable.add(current);
		}
		return roomAvailable;

	}

	public List<Room> saveAvailableRoom(Map<Long, Room> roomsFromHotel, List<Date> bookingDate, int numberRooms,
			RoomType rt, List<Room> rooms_available, Booking booking) {
		int counter = 1;
		for (Long entry : roomsFromHotel.keySet()) {
			Room r = roomsFromHotel.get(entry);

			Map<Date, Long> room_bookings = r.getDays_reserved();
			boolean reserved = false;
			Iterator<Date> dates = bookingDate.iterator();

			while (dates.hasNext()) {
				Date day = dates.next();
				if (room_bookings.get(day) != null) {
					reserved = true;
					break;
				}
			}

			if (!reserved && r.getType() == rt && counter <= numberRooms) {
				rooms_available.add(r);
				for (Date date : bookingDate)
					room_bookings.put(date, booking.getId());
				counter++;
			} else if (counter > numberRooms)
				break;
		}
		return rooms_available;
	}

}
