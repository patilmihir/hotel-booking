package com.mihir.bookingApp.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.mihir.bookingApp.dao.BookingDAO;
import com.mihir.bookingApp.dao.HotelDAO;
import com.mihir.bookingApp.dao.RoomDAO;
import com.mihir.bookingApp.model.Booking;
import com.mihir.bookingApp.model.Hotel;
import com.mihir.bookingApp.model.Room;

@Controller
public class HomeController {

	@Autowired
	@Qualifier("hotelDao")
	HotelDAO hotelDao;

	@Autowired
	@Qualifier("bookingDao")
	BookingDAO bookingDao;

	@Autowired
	@Qualifier("roomDao")
	RoomDAO roomDao;

	// Get hotel information on home page
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView registerRedirect(HttpServletRequest request) throws Exception {
		reserveBooking();
		ModelAndView model = new ModelAndView();
		List<Hotel> hotels = hotelDao.getHotels();
		model.addObject("hotels", hotels);
		model.setViewName("index");
		return model;
	}

	@RequestMapping(value = "/error.htm", method = RequestMethod.GET)
	public ModelAndView redirectError(HttpServletRequest request) throws Exception {
		ModelAndView model = new ModelAndView();
		model.setViewName("error");
		return model;
	}

	// Book rooms - prerequisite
	private void reserveBooking() throws Exception {

		List<Object> objects = bookingDao.getPreCheck();
		if(objects.size()>0){
			return;
		}
		List<Booking> books = bookingDao.getBooking();

		for (Booking book : books) {
			Date begin = book.getBegin_date();
			Date end = book.getEnd_date();
			List<Date> dates = new ArrayList<Date>();
			Calendar calendar = new GregorianCalendar();
			calendar.setTime(begin);

			while (calendar.getTime().getTime() <= end.getTime()) {
				Date result = calendar.getTime();
				dates.add(result);
				calendar.add(Calendar.DATE, 1);
			}

			Map<Date, Long> tmpMap = new HashMap<Date, Long>();

			for (Date d : dates) {
				tmpMap.put(d, book.getId());
			}

			Set<Room> rt = book.getRooms();

			for (Room r : rt) {
				r.setDays_reserved(tmpMap);
				roomDao.save(r);
			}

			bookingDao.save(book);
		}

	}

}
