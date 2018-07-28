package com.pulse.webtool.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Session
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String un = request.getParameter("uname");
		String pwd = request.getParameter("pass");
		if (un.equalsIgnoreCase("Pulse")&&pwd.equals("testtest")) {
			out.print("Welcome, " + un);
			HttpSession session = request.getSession(true); // reuse existing
															// session if exist
															// or create one
			session.setAttribute("user", un);
			session.setMaxInactiveInterval(3000); // 3000 seconds
			session.removeAttribute("loginError");
			response.sendRedirect("home.jsp");
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			HttpSession session = request.getSession(true); 
			session.removeAttribute("user");
			session.setAttribute("loginError", "error");
			session.setMaxInactiveInterval(10); // 30 seconds
			//out.println("_$(\"login_message\").innerHTML = \"<p style=\"color:red;\">testtest</p>;\"" );
			rd.include(request, response);
		} // TODO Auto-generated method stub
	}
}