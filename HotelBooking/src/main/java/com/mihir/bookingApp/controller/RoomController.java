package com.mihir.bookingApp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.mihir.bookingApp.dao.HotelDAO;
import com.mihir.bookingApp.dao.RoomDAO;
import com.mihir.bookingApp.exception.HotelException;
import com.mihir.bookingApp.exception.RoomException;
import com.mihir.bookingApp.model.Hotel;
import com.mihir.bookingApp.model.Room;
import com.mihir.bookingApp.model.RoomType;

@Controller
public class RoomController {

	@Autowired
	@Qualifier("hotelDao")
	HotelDAO hotelDao;

	@Autowired
	@Qualifier("roomDao")
	RoomDAO roomDao;

	// Display all rooms of a particular hotel
	@RequestMapping(value = "/hotels/{id}/rooms.htm", method = RequestMethod.GET)
	public ModelAndView showRooms(HttpServletRequest request, @PathVariable("id") long id) throws HotelException {
		Hotel hotel = hotelDao.getHotel(id);
		ModelAndView model = new ModelAndView();
		System.out.println(request.getSession().getAttribute("isManager"));
		if (request.getSession().getAttribute("id") != null
				&& request.getSession().getAttribute("id").equals(hotel.getManager().getId())) {
			Map<Long, Room> hotelRoomList = hotel.getRooms();
			model.addObject("hotel", hotel);
			model.addObject("rooms", hotelRoomList);
			model.setViewName("rooms/index");
		} else {
			model.setViewName("error");
		}
		return model;
	}

	// Add Room
	@RequestMapping(value = "/hotels/{id}/create.htm", method = RequestMethod.GET)
	public ModelAndView addRoom(HttpServletRequest request, @PathVariable("id") long id) throws HotelException {

		Hotel hotel = hotelDao.getHotel(id);
		ModelAndView model = new ModelAndView();
		if (request.getSession().getAttribute("id") != null
				&& request.getSession().getAttribute("id").equals(hotel.getManager().getId())) {
			List<RoomType> typeList = hotelDao.getRoomTypes();			
			model.addObject("hotel", hotel);
			model.addObject("room", new Room());
			model.addObject("roomTypes", typeList);
			model.setViewName("rooms/add");
		} else {
			model.setViewName("error");
		}
		return model;
	}

	//Save Room
	@RequestMapping(value = "/hotels/{id}/add.htm", method = RequestMethod.POST)
	public ModelAndView saveRoom(HttpServletRequest request, Model model, @PathVariable("id") long id,
			@ModelAttribute Room room, BindingResult result) throws HotelException, RoomException {
		//Custom validation messages
		Map<String, String> messages = new HashMap<String, String>();
		Hotel hotel = hotelDao.getHotel(id);
		room.setHotel(hotel);
		//Check if room number already exist for that hotel
		messages = roomDao.validateRoom(room, messages);
		ModelAndView view = new ModelAndView();
		room.setHotel(hotel);
		if (messages.size() > 0) {
			List<RoomType> typeList = hotelDao.getRoomTypes();
			view.addObject("hotel", hotel);
			view.addObject("room", room);
			view.addObject("roomTypes", typeList);
			view.addObject("messages", messages);
			view.setViewName("rooms/add");
			return view;
		}
		RoomType type = roomDao.getRoomType(Long.parseLong(request.getParameter("roomType")));
		room.setType(type);
		roomDao.save(room);
		view.addObject("hotelId", id);
		view.setViewName("rooms/confirmation");
		return view;

	}

	@RequestMapping(value = "/hotels/{id}/add.htm", method = RequestMethod.GET)
	public ModelAndView redirectError(HttpServletRequest request, Model model, @PathVariable("id") long id,
			@ModelAttribute Room room, BindingResult result) throws HotelException, RoomException {

		ModelAndView view = new ModelAndView();
		view.setViewName("error");
		return view;

	}
}
