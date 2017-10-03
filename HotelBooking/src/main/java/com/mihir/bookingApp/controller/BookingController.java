package com.mihir.bookingApp.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.mihir.bookingApp.dao.BookingDAO;
import com.mihir.bookingApp.dao.HotelDAO;
import com.mihir.bookingApp.dao.RoomDAO;
import com.mihir.bookingApp.exception.HotelException;
import com.mihir.bookingApp.exception.RoomException;
import com.mihir.bookingApp.model.Booking;
import com.mihir.bookingApp.model.Hotel;
import com.mihir.bookingApp.model.Room;
import com.mihir.bookingApp.model.RoomType;
import com.mihir.bookingApp.model.User;

@Controller
@SessionAttributes({ "booking", "numberRooms", "roomType" })
public class BookingController {

	@Autowired
	@Qualifier("roomDao")
	RoomDAO roomDao;

	@Autowired
	@Qualifier("hotelDao")
	HotelDAO hotelDao;

	@Autowired
	@Qualifier("bookingDao")
	BookingDAO bookingDao;

	// Display page to book a room
	@RequestMapping(value = "/bookings/new.htm", method = RequestMethod.GET)
	public ModelAndView newBookingRedirect(HttpServletRequest request) throws Exception {
		ModelAndView model = new ModelAndView();
		model.addObject("booking", new Booking());
		model.addObject("roomTypes", roomDao.getRoomTypes());
		model.setViewName("bookings/create");
		return model;
	}

	// Search available rooms as per user criteria
	@RequestMapping(value = "/bookings/search.htm", method = RequestMethod.POST)
	public String searchRooms(@ModelAttribute Booking booking, Model model, @RequestParam("roomType") long roomType,
			@RequestParam("numberRooms") int numberRooms) throws HotelException, RoomException {

		RoomType rt = roomDao.getRoomType(roomType);
		List<Room> roomAvailable = new ArrayList<Room>();
		List<Date> dateRange = getDates(booking);
		List<Hotel> hotelList = hotelDao.getHotels();
		roomAvailable = roomDao.getRoomAvailable(hotelList, dateRange, roomAvailable, numberRooms, rt);
		model.addAttribute("rooms", roomAvailable);
		model.addAttribute("booking", booking);
		model.addAttribute("roomType", rt);
		model.addAttribute("numberRooms", numberRooms);
		return "bookings/results";
	}

	@RequestMapping(value = "/bookings/search.htm", method = RequestMethod.GET)
	public String redirectError(HttpServletRequest request) throws HotelException, RoomException {

		return "error";
	}

	// Save user booking
	@RequestMapping(value = "/bookings/new/{hotel_id}", method = RequestMethod.GET)
	public String bookRoom(HttpServletRequest request, Model model, @PathVariable("hotel_id") long hotel_id,
			@ModelAttribute("booking") Booking booking, @ModelAttribute("numberRooms") int numberRooms,
			@ModelAttribute("roomType") RoomType roomType) throws RoomException, HotelException {
		// Get type of room requested
		RoomType rt = roomDao.getRoomType(roomType.getId());

		// Stores all dates from & to(inclusive)
		List<Date> bookingDate = getDates(booking);
		HttpSession session = request.getSession();

		// Check to see if user session exist
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/users/login.htm";
		} else {
			// Set user to booking object
			booking.setUser(user);
			Hotel hotel = hotelDao.getHotel(hotel_id);

			// Get all rooms of that hotel
			Map<Long, Room> roomsFromHotel = hotel.getRooms();
			// Store available rooms
			List<Room> rooms_available = new ArrayList<Room>();

			rooms_available = roomDao.saveAvailableRoom(roomsFromHotel, bookingDate, numberRooms, rt, rooms_available,
					booking);
			Set<Room> roomsBooking = new HashSet<Room>(rooms_available);
			booking.setRooms(roomsBooking);
			booking.setState(true);
			bookingDao.save(booking);
			model.addAttribute("bookings", bookingDao.getBooking());
			return "redirect:/users/me";
		}
	}

	// Cancel booking - Set status of booking as false
	// It needs to be approved by hotel manager in order to be deleted
	@RequestMapping(value = "/bookings/{booking_id}/cancel", method = RequestMethod.GET)
	public String cancelBooking(Model model, @PathVariable("booking_id") long booking_id)
			throws RoomException, HotelException {
		Booking booking = bookingDao.getBooking(booking_id);

		booking.setState(false);
		bookingDao.save(booking);
		return "redirect:/users/me";
	}

	// Delete booking
	// Once the hotel manager approves cancellation request the booking is
	// deleted
	@RequestMapping(value = "/bookings/{booking_id}/remove", method = RequestMethod.GET)
	public String removeBooking(Model model, @PathVariable("booking_id") long booking_id)
			throws RoomException, HotelException {
		Booking booking = bookingDao.getBooking(booking_id);

		Set<Room> rooms = booking.getRooms();
		Iterator<Room> it = rooms.iterator();

		while (it.hasNext()) {
			Room room = it.next();
			Map<Date, Long> daysReserved = room.getDays_reserved();

			List<Date> dates = getDates(booking);

			for (Date d : dates)
				daysReserved.remove(d);

			room.setDays_reserved(daysReserved);
		}

		bookingDao.delete(booking);
		return "redirect:/users/me";
	}

	// Create a List<Date> collection from checking & checkout date
	private List<Date> getDates(Booking booking) {

		List<Date> dates = new ArrayList<Date>();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(booking.getBegin_date());

		while (calendar.getTime().getTime() <= booking.getEnd_date().getTime()) {
			Date result = calendar.getTime();
			dates.add(result);
			calendar.add(Calendar.DATE, 1);
		}
		return dates;
	}

}
