package com.web.home.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginData") == null) {
			String qs = "";
			if(request.getQueryString() != null) {
				qs = "?" + request.getQueryString();
			}
			response.sendRedirect(request.getContextPath() + "/login?url=" + request.getRequestURI() + qs);
			return false;
		} else {
			return true;
		}
	}
}
