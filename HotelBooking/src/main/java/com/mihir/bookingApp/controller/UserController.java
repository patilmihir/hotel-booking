package com.mihir.bookingApp.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.mihir.bookingApp.dao.BookingDAO;
import com.mihir.bookingApp.dao.CommentDAO;
import com.mihir.bookingApp.dao.UserDAO;
import com.mihir.bookingApp.exception.UserException;
import com.mihir.bookingApp.model.Authority;
import com.mihir.bookingApp.model.Comment;
import com.mihir.bookingApp.model.User;
import com.mihir.bookingApp.validator.UserValidator;

@Controller
public class UserController {

	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;

	@Autowired
	@Qualifier("bookingDao")
	BookingDAO bookingDao;

	@Autowired
	@Qualifier("commentDao")
	CommentDAO commentDao;

	@Autowired
	@Qualifier("userValidator")
	UserValidator userValidator;

	@InitBinder
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(userValidator);
	}

	// Redirect to login page
	@RequestMapping(value = { "/users/login.htm" }, method = RequestMethod.GET)
	public ModelAndView loginRedirect(HttpServletRequest request) {
		return new ModelAndView("login");
	}

	// Redirect to registration page
	@RequestMapping(value = { "/users/register.htm" }, method = RequestMethod.GET)
	public ModelAndView registerRedirect(HttpServletRequest request) {
		return new ModelAndView("register", "user", new User());
	}

	// Register
	@RequestMapping(value = { "/users/register.htm" }, method = RequestMethod.POST)
	public ModelAndView registerNewUser(HttpServletRequest request, @ModelAttribute("user") User user,
			BindingResult result) {
		try {
			boolean valid = false;

			// Validation to check if user-name/email already exist
			userValidator.validate(user, result);
			if (result.hasErrors()) {
				valid = true;
				ModelAndView model = new ModelAndView();
				model.addObject("valid", valid);
				model.addObject("user", user);
				model.setViewName("register");
				return model;
			}
			HttpSession session = (HttpSession) request.getSession();

			// Set user authority
			Authority authority = userDao.getAuthorityByRole("ROLE_USER");
			user.setAuthority(authority);

			// Save user
			User u = userDao.register(user);

			// Set session attributes of user information if credentials are
			// valid
			session.setAttribute("id", u.getId());
			session.setAttribute("user", u);
			session.setAttribute("role", u.getAuthority().getRole());

			// Get all comments written by user
			List<Comment> comments = commentDao.getComments(u.getId());

			// Add user, booking, comments in ModelAndView object
			ModelAndView model = new ModelAndView();
			model.addObject("bookings", bookingDao.getUserBooking(user.getId()));
			model.addObject("comments", comments);
			model.addObject("user", user);
			model.setViewName("users/show");
			return model;
		} catch (Exception e) {
			ModelAndView model = new ModelAndView();
			model.setViewName("error");
			return model;
		}
	}

	// Login
	@RequestMapping(value = { "/users/login.htm" }, method = RequestMethod.POST)
	protected String loginUser(HttpServletRequest request) throws Exception {
		HttpSession session = (HttpSession) request.getSession();
		try {
			// Check if credentials are valid
			User u = userDao.get(request.getParameter("username"), request.getParameter("password"));
			if (u == null) {
				return "loginerror";
			}
			// Set session attributes of user information if credentials are
			// valid
			session.setAttribute("id", u.getId());
			session.setAttribute("user", u);
			session.setAttribute("role", u.getAuthority().getRole());
			return "redirect:/users/me";
		} catch (UserException e) {
			System.out.println("User Exception: " + e.getMessage());
			return "error";
		}
	}

	@RequestMapping(value = "/users/me", method = RequestMethod.GET)
	public ModelAndView profileRedirect(HttpServletRequest request) {
		try {
			long id = (Long) request.getSession().getAttribute("id");
			User user = userDao.findUser(id);
			List<Comment> comments = commentDao.getComments(id);
			ModelAndView model = new ModelAndView();
			model.addObject("bookings", bookingDao.getUserBooking(user.getId()));
			model.addObject("comments", comments);
			model.addObject("user", user);
			model.setViewName("users/show");
			return model;
		} catch (Exception e) {
			ModelAndView model = new ModelAndView();
			model.setViewName("error");
			return model;
		}
	}

	@RequestMapping(value = { "/users/logout.htm" }, method = RequestMethod.POST)
	public String logout(HttpServletRequest request) {
		// Invalidate session
		request.getSession().invalidate();
		// Redirect to home page
		return "redirect:/";
	}

}
