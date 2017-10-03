package com.mihir.bookingApp.validator;

import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mihir.bookingApp.dao.UserDAO;
import com.mihir.bookingApp.model.User;

@Component
public class UserValidator implements Validator {

	@Autowired
	@Qualifier("userDao")
	UserDAO userDao;

	public boolean supports(Class aClass) {
		return aClass.equals(User.class);
	}

	public void validate(Object obj, Errors errors) {
		User user = (User) obj;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "error.invalid.user", "Please enter Name");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "error.invalid.user", "Please enter Username");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "error.invalid.password", "Please enter E-mail");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "error.invalid.email", "Please enter Password");

		if (errors.hasErrors()) {
			return;
		}
				
		Pattern name = Pattern.compile("[^a-zA-Z' ']");
		Pattern username = Pattern.compile("[^a-zA-Z0-9]");
		

		if (name.matcher(user.getName()).find()) {
			errors.rejectValue("name", "name-invalid", "Please enter valid Name");
		}
		if (username.matcher(user.getUsername()).find()) {
			errors.rejectValue("username", "username-invalid", "Please enter valid Username");
		}

	
		String userName = user.getUsername();
		String email = user.getEmail();
		boolean emailExist = userDao.validateEmail(email);
		boolean userNameExist = userDao.validateUsername(userName);
		if (emailExist) {
			errors.rejectValue("email", "email-invalid", "Email-id is already registered.");
		}
		if (userNameExist) {
			errors.rejectValue("username", "username-invalid", "Please select a different Username.");
		}

	}
}
