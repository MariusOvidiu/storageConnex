<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.pulse.webtool.servlet.*"%>
<html>
<head>
<title>HTTP Header Request Example</title>
</head>

<body>

	<%
		out.println(WebController.getJavaCall(request));
	%>

</body>
</html>