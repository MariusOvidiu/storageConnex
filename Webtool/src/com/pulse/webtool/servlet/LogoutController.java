package com.pulse.webtool.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutSession
 */
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String html = "" + "<html>" + "<head>" + "<style>\n" + "input.MyButton {\n" + "width: 300px;\n"
				+ "padding: 20px;\n" + "cursor: pointer;\n" + "font-weight: bold;\n" + "font-size: 150%;\n"
				+ "background: #3366cc;\n" + "color: #fff;\n" + "border: 1px solid #3366cc;\n"
				+ "border-radius: 10px;\n" + "}\n" +

				"</style>" + "<title>Display Msg</title>"

				+ "</head>" + "<body>";
		html = html + "Thank you!! You have successfully logged out! <br> Click below to login again";
		html = html + "<form>\n"
				+ "<input class=\"MyButton\" type=\"button\" value=\"Login\" onclick=\"window.location.href='index.jsp'\" />\n"
				+ "</form>";

		html = html + "</body>" + "</html>";
		out.print(html);
		HttpSession session = request.getSession(false);
		// session.setAttribute("user", null);
		session.removeAttribute("user");
		session.getMaxInactiveInterval();

	}
}
