package com.mihir.bookingApp.exception;

public class HotelException extends Exception {

	public HotelException(String message) {
		super("Hotel Exception:" + message);
	}
	
	public HotelException(String message, Throwable clause) {
		super("Hotel Exception:"+ message, clause);
	}
}
