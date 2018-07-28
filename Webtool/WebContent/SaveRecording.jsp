<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="com.pulse.webtool.servlet.*"%>
<%
	if (session != null) {
		if (session.getAttribute("user") != null) {
			String name = (String) session.getAttribute("user");

			File file;
			int maxFileSize = 30000 * 1024;
			int maxMemSize = 30000 * 1024;
			ServletContext context = pageContext.getServletContext();
			String tempFolderPath="webapps\\Webtool\\temp\\";
			String filePath = tempFolderPath;

			// Verify the content type
			String contentType = request.getContentType();
			WebController.logger("SaveRecording", contentType);
			
			if ((contentType.indexOf("multipart/form-data") >= 0)) {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// maximum size that will be stored in memory
				factory.setSizeThreshold(maxMemSize);

				// Location to save data that is larger than maxMemSize.
				factory.setRepository(new File("c:\\temp"));

				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);

				// maximum file size to be uploaded.
				upload.setSizeMax(maxFileSize);

				try {
					// Parse the request to get file items.
					List fileItems = upload.parseRequest(request);

					// Process the uploaded file items
					Iterator i = fileItems.iterator();

					while (i.hasNext()) {
						FileItem fi = (FileItem) i.next();
						if (!fi.isFormField()) {
							// Get the uploaded file parameters
							String fieldName = fi.getFieldName();
							String fileName = fi.getName();
							boolean isInMemory = fi.isInMemory();
							long sizeInBytes = fi.getSize();

							// Write the file
							if (fileName.lastIndexOf("\\") >= 0) {
								file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
							} else {
								file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
							}
							fi.write(file);
							out.println(GenerateHTML.getHTMLOK("Uploaded Filename: " + filePath + fileName));
							CallAudioConverter.convertAudio(fileName);
						}
					}

				} catch (Exception ex) {
					System.out.println(ex);
				}
			} else {
				out.println(GenerateHTML.getHTMLError("Error Uploading"));
			}

		} else {
			response.sendRedirect("index.jsp");
		}
	} else {
		response.sendRedirect("index.jsp");
	}
%>