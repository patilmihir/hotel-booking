package com.mihir.bookingApp.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.mihir.bookingApp.dao.CommentDAO;
import com.mihir.bookingApp.dao.HotelDAO;
import com.mihir.bookingApp.exception.CommentException;
import com.mihir.bookingApp.exception.HotelException;
import com.mihir.bookingApp.model.Comment;
import com.mihir.bookingApp.model.Hotel;
import com.mihir.bookingApp.model.RoomType;
import com.mihir.bookingApp.model.User;
import com.mihir.bookingApp.model.Room;

@Controller

public class HotelController {

	@Autowired
	@Qualifier("hotelDao")
	HotelDAO hotelDao;

	@Autowired
	@Qualifier("commentDao")
	CommentDAO commentDao;

	// Display list of all hotels
	@RequestMapping(value = { "/hotels/index.htm" }, method = RequestMethod.GET)
	public ModelAndView hotelListRedirect(HttpServletRequest request) throws Exception {
		ModelAndView model = new ModelAndView();
		List<Hotel> hotelList = hotelDao.getHotels();
		model.addObject("hotels", hotelList);
		model.setViewName("hotels/index");
		return model;
	}

	// Display hotels as per search criteria
	@RequestMapping(value = "/hotels/search", method = RequestMethod.POST)
	public String searchHotel(Model model, @RequestParam("hotel") String searchString) throws HotelException {
		List<Hotel> hotelList = hotelDao.getHotels();
		List<Hotel> hotelSuggessionList = new ArrayList<Hotel>();
		for (Hotel hotel : hotelList) {
			if (hotel.getName().toLowerCase().contains(searchString.toLowerCase()))
				hotelSuggessionList.add(hotel);
		}

		model.addAttribute("hotels", hotelSuggessionList);
		return "hotels/index";
	}

	// Get list of hotel as per key press event for auto-complete
	@RequestMapping(value = "/hotels/autocomplete", method = RequestMethod.GET, produces = { "text/plain",
			"application/json" })
	@ResponseBody
	public String getHotelNames(@RequestParam String keyword, HttpServletRequest request) throws Exception {
		List<Hotel> hotelList = hotelDao.getHotelByName(keyword);
		String tags = generateJsonData(hotelList);
		return tags;
	}

	// Display details of a hotel
	@RequestMapping(value = "/hotels/{id}", method = RequestMethod.GET)
	public ModelAndView show(HttpServletRequest request, @PathVariable("id") long id) throws HotelException {
		Hotel hotel = hotelDao.getHotel(id);
		if (request.getSession().getAttribute("id") != null) {
			long userId = (Long) request.getSession().getAttribute("id");
			long managerId = hotel.getManager().getId();
			if (userId == managerId) {
				request.getSession().setAttribute("isManager", "true");
			} else {
				request.getSession().removeAttribute("isManager");
			}
		}

		ModelAndView model = new ModelAndView();
		Map<Long, Comment> commentCollection = hotel.getComments();
		model.addObject("hotel", hotel);
		model.addObject("comments", commentCollection);
		model.addObject("comment", new Comment());
		List<RoomType> roomTypesCollection = hotelDao.getRoomTypes();
		model.addObject("roomTypes", roomTypesCollection);
		Map<Long, Room> roomList = hotel.getRooms();
		Map<RoomType, Room> roomTypeList = new HashMap<RoomType, Room>();
		for (Room r : roomList.values()) {
			roomTypeList.put(r.getType(), r);
		}
		model.addObject("hotelRoomTypes", roomTypeList);
		model.setViewName("hotels/show");
		return model;
	}

	// Save user comments
	@RequestMapping(value = "/hotels/{id}/comment", method = RequestMethod.POST)
	public String saveComment(HttpServletRequest request, @ModelAttribute Comment comment, Model model,
			@PathVariable("id") long id) throws HotelException, CommentException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		Hotel hotel = hotelDao.getHotel(id);
		Date date = new Date();
		comment.setDate(date);
		comment.setUser(user);
		comment.setHotel(hotel);
		commentDao.save(comment);
		return "redirect:/hotels/{id}";
	}

	// Method to generate JSON data for auto-complete operation
	private String generateJsonData(List<Hotel> hotels) {
		String tags = "[";
		for (int i = 0; i < hotels.size(); i++) {
			if (i < hotels.size() - 1)
				tags += "\"" + hotels.get(i).getName() + "\",";
			else
				tags += "\"" + hotels.get(i).getName() + "\"";
		}
		tags += "]";
		return tags;
	}

}
