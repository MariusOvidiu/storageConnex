<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Pulse Webtool</title>

<link rel="stylesheet" href="css/menustyle.css" media="screen"
	type="text/css" />

<!-- include css and javascript sources for this demo -->
<link rel="stylesheet" type="text/css" href="css/simple.css"
	media="screen" />
<link rel="stylesheet" type="text/css" href="css/style.css"
	media="screen" />


</head>
<body>


	<div id="wrap"  style="width: 1196px; margin: 0px auto;">
	
<a href="home.jsp">
<img src="images/logo_small.png" >
</a>


		<ul id="menu-bar">
			
			<li><a href="#">Account</a>
				<ul>
					<li><a href="#">AccountDeailt</a></li>
					<li><a href="#">ChangePassword</a></li>
					<li><a href="#"
						onclick="document.getElementById('logout_form').submit();return false;">Logout</a></li>

				</ul></li>
				<li><a href="home.jsp">Messages</a>
				<ul>
					<li><a href="home.jsp">All Messages</a></li>
					<li><a href="home.jsp">Edit Message</a></li>

				</ul></li>
			<li><a href="#">User Admin</a>
				<ul>
					<li><a href="#">Manage Users</a></li>
					<li><a href="#">Add User</a></li>

				</ul></li>
			<li class="active"><a href="#">Tools</a>
				<ul>
					<li><a href="recorder.jsp">Audio Recorder</a></li>
					<li><a href="recorder.jsp">Audio Converter</a></li>
				</ul></li>
			<li><a href="#">Help</a>
				<ul>
					<li><a href="#">Help</a></li>
					<li><a href="#">About</a></li>

				</ul></li>
		</ul>
		<br>
	<br>
<%
			if (session != null) {
				if (session.getAttribute("user") != null) {
					String name = (String) session.getAttribute("user");
					
				} else {
					response.sendRedirect("index.jsp");
				}
			}
		%>
	<br>
	
		<h1>Recording Tool</h1>


		<h2>Please enable microphone input when prompted</h2>

		<button onclick="startRecording(this);">record</button>
		<button onclick="stopRecording(this);" disabled>stop</button>
		<br>
		
	
		<br>
		<h2>Recordings List</h2>
		<ul id="recordingslist" style="list-style: none; padding:0; margin:0;"></ul>
		
		<h2>Recording Log</h2>
		<pre id="log"></pre>
		
		
</div>
		<script>
			function __log(e, data) {
				log.innerHTML += "\n" + e + " " + (data || '');
			}

			var audio_context;
			var recorder;
			var t_FileName;
			function startUserMedia(stream) {
				var input = audio_context.createMediaStreamSource(stream);
				__log('Media stream created.');

				// Uncomment if you want the audio to feedback directly
				//input.connect(audio_context.destination);
				//__log('Input connected to audio context destination.');

				recorder = new Recorder(input);
				__log('Recorder initialised.');
			}

			function startRecording(button) {
				recorder && recorder.record();
				button.disabled = true;
				button.nextElementSibling.disabled = false;
				__log('Recording...');
			}

			function stopRecording(button) {
				recorder && recorder.stop();
				button.disabled = true;
				button.previousElementSibling.disabled = false;
				__log('Stopped recording.');

				// create WAV download link using audio data blob
				createDownloadLink();

				recorder.clear();
			}
	
		
			function uploadBlob(blob) {

				var reader = new FileReader();
				// this function is triggered once a call to readAsDataURL returns
				reader.onload = function(event) {
					var fd = new FormData();
					fd.append("myfile", blob, t_FileName+".wav");

					var request = new XMLHttpRequest();
					request.onreadystatechange = function() {
						if (this.readyState == 4 && this.status == 200) {
							   // Typical action to be performed when the document is ready:
						var li = document.createElement('li');
						var au = document.createElement('audio');
						
						
						au.setAttribute("src","temp/"+t_FileName+".vox");
						au.setAttribute("type","audio/wav");
					
						var hf = document.createElement('a');
						au.controls = true;
						hf.href = "temp/"+t_FileName+".vox";
						hf.download = t_FileName+".vox";
						//hf.style="text-decoration: none;";
						hf.innerHTML = "Click Download";
						
						li.appendChild(au);
						li.appendChild( document.createTextNode( '\u00A0' ) );
						li.appendChild(hf);
						recordingslist.appendChild(li);
						}
					};
					request.open("POST", "SaveRecording.jsp");
					request.send(fd);
				};
				// trigger the read from the reader...
				reader.readAsDataURL(blob);

			}

			function createDownloadLink() {
				recorder && recorder.exportWAV(function(blob) {
					 var d = new Date();
					var n = d.getTime();
					 t_FileName=n;
					 uploadBlob(blob);
					
					
				});
			}

			window.onload = function init() {
				try {
					// webkit shim
					window.AudioContext = window.AudioContext
							|| window.webkitAudioContext;
					navigator.getUserMedia = navigator.getUserMedia
							|| navigator.webkitGetUserMedia
							|| navigator.mozGetUserMedia
							|| navigator.msGetUserMedia;

					window.URL = window.URL || window.webkitURL;

					audio_context = new AudioContext;
					__log('Audio context set up.');
					__log('Microphone Check: '
							+ (navigator.getUserMedia ? 'Microphone is available.'
									: 'Microphone is not available!'));
				} catch (e) {
					alert('No web audio support in this browser!');
				}

				navigator.getUserMedia({
					audio : true
				}, startUserMedia, function(e) {
					__log('No live audio input: ' + e);
				});
			};
		</script>

		<script src="recorder.js"></script>

<form id="logout_form" action="Logout" method="post">
		<input type="hidden" value="Logout">
	</form>




		
	
</body>
</html>