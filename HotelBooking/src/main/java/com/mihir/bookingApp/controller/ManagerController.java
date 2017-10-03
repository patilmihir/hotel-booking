package com.mihir.bookingApp.controller;

import java.util.ArrayList;
import java.util.List;
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
import com.mihir.bookingApp.model.User;

@Controller
public class ManagerController {
	

	@Autowired
	@Qualifier("roomDao")
	RoomDAO roomDao;
	
	@Autowired
	@Qualifier("hotelDao")
	HotelDAO hotelDao;
	
	@Autowired
	@Qualifier("bookingDao")
	BookingDAO bookingDao;
	
	// View all booking of that hotel - Hotel Manager
	@RequestMapping(value="/dashboard/view.htm", method=RequestMethod.GET)
	public ModelAndView viewAllBooking(HttpServletRequest request) throws Exception 
	{
		
		User user = (User) request.getSession().getAttribute("user");
		Set<Hotel> hotelList = user.getHotels();
		List<Booking> booking = bookingDao.getBooking();
		List<Booking> hotelBooking = new ArrayList<Booking>();
		for(Booking b: booking) {
			if(b.getHotel().getManager().getId() == user.getId()){
				hotelBooking.add(b);
			}
		}				
		ModelAndView model = new ModelAndView();
		model.addObject("bookings",hotelBooking);
		model.addObject("hotels",hotelList);
		model.setViewName("manager/dashboard");
		return model;	
	}

}
