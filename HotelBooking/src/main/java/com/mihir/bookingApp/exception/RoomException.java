package com.mihir.bookingApp.exception;

public class RoomException extends Exception {

	public RoomException(String message) {
		super("Room Exception:" + message);
	}
	
	public RoomException(String message, Throwable clause) {
		super("Room Exception:"+ message, clause);
	}
}