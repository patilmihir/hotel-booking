package com.mihir.bookingApp.exception;

public class UserException extends Exception {

	public UserException(String message) {
		super("User Exception:" + message);
	}
	
	public UserException(String message, Throwable clause) {
		super("User Exception:"+ message, clause);
	}
}
