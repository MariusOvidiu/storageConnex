<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Broadcast Message Webtool Login</title>

<link rel="stylesheet" href="css/style.css" media="screen"
	type="text/css" />

</head>

<body>

	<div class="login-card">
	<!--<img src="images/rogersIcon.png" style="width:150px;"-->
	<img src="images/WebtoolLargeIcon.png" style="width:274px;">
		
		
		<h3 style="text-align:center; font-family: 'Arial', sans-serif; color:#646464;">Broadcast Webtool</h3>
		<br>
		<form action="Login" method="post">
			<input type="text" name="uname" placeholder="Username"> <input
				type="password" name="pass" placeholder="Password"> <input
				type="submit" name="Login" class="login login-submit" value="Login">
		</form>
		
		<%
			if (session != null) {
				if (session.getAttribute("loginError") != null) {

					out.print(
							"<div class=\"login-error\" id=\"login_message\">	<p style=\"color: red;\">Invalid Login</p></div>");
				}
			}
		%>
	</div>



</body>

</html>



