package com.mihir.bookingApp.exception;

import com.mihir.bookingApp.dao.DAO;

public class CommentException extends Exception {

		public CommentException(String message) {
			super("Comment Exception:" + message);
		}
		
		public CommentException(String message, Throwable clause) {
			super("Comment Exception:"+ message, clause);
		}

}
