package com.pulse.webtool.servlet;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

public class GenerateHTML {
	private static Logger log = Logger.getLogger(GenerateHTML.class);

	public static String getHTMLError(String msg) {
		log.debug("getHTMLError enter with[" + msg + "]");

		String html = getHTML(msg, "rederror");
		return html;

	}

	public static String getHTMLOK(String msg) {
		log.debug("getHTMLOK enter with[" + msg + "]");
		String html = getHTML(msg, "ok");

		return html;

	}

	public static String getHTML(HttpServletRequest request) {
		log.debug("getHTML enter with[" + request + "]");
		String msg = request.getParameter("msg_value");
		String style = request.getParameter("msg_style");
		log.debug("getHTML msg[" + msg + "]");
		log.debug("getHTML style[" + style + "]");
		String html = getHTML(msg, style);

		return html;

	}

	public static String getHTML(String msg, String style) {
		String html = "" + "<html>" + "<head>" + "<style>\n" + "*{" + "    margin: 0;" + "    padding: 0;"
				+ "}</style>\n" + "<title>Display Msg</title>"

				+ " <link rel=\"stylesheet\" type=\"text/css\" href=\"css/simple.css\"	media=\"screen\" />"

				+ "</head>" + "<body>" + "<p class=\"" + style + "\">"

				+ msg + "</p></body>" + "</html>";

		return html;

	}
}
