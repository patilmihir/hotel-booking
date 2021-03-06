package com.mihir.bookingApp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {

	String errorPage;

	public String getErrorPage() {
		return errorPage;
	}

	public void setErrorPage(String errorPage) {
		this.errorPage = errorPage;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {		

		HttpSession session = (HttpSession) request.getSession();
	

		if (session.getAttribute("user") != null && session.getAttribute("role").equals("ROLE_HOTEL_MANAGER")) {
			return true;
		}


		response.sendRedirect(errorPage);
		return false;

	}

}
