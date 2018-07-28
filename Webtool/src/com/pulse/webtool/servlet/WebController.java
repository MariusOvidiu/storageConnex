package com.pulse.webtool.servlet;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

public class WebController {
	private static Logger log = Logger.getLogger(WebController.class);

	public static String getJavaCall(HttpServletRequest request) {
		log.debug("getJavaCall enter with[" + request + "]");
		String name = request.getParameter("java_msg_name");
		String data = request.getParameter("java_msg_data");
		String metadata = request.getParameter("java_msg_metadata");
		log.debug("getJavaCall name[" + name + "]");
		log.debug("getJavaCall data[" + data + "]");
		if(name.equalsIgnoreCase("saveTable")) {
			DataController.saveToFile(metadata, data);
		}
		
		
		String html = GenerateHTML.getHTML("success", "ok");
		
		return html;

	}

	public static void logger(String name, String msg) {
		log.debug(name + "  " + msg);
	}
}
