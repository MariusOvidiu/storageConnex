<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.pulse.webtool.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Pulse Webtool</title>

<script src="editablegrid.js"></script>
<!-- [DO NOT DEPLOY] -->
<script src="editablegrid_renderers.js"></script>
<!-- [DO NOT DEPLOY] -->
<script src="editablegrid_editors.js"></script>
<!-- [DO NOT DEPLOY] -->
<script src="editablegrid_validators.js"></script>
<!-- [DO NOT DEPLOY] -->
<script src="editablegrid_utils.js"></script>
<!-- [DO NOT DEPLOY] -->
<script src="editablegrid_charts.js"></script>
<script src="pagenator.js"></script>
<link rel="stylesheet" href="css/editablegrid.css" type="text/css"
	media="screen">
<link rel="stylesheet" href="css/menustyle.css" media="screen"
	type="text/css" />
<!-- include javascript and css files for jQuery UI, in order to have the datepicker -->
<script src="extensions/jquery/jquery-1.6.4.min.js"></script>
<script src="extensions/jquery/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet"
	href="extensions/jquery/jquery-ui-1.8.16.custom.css" type="text/css"
	media="screen">

<!-- include css and javascript sources for this demo -->
<link rel="stylesheet" type="text/css" href="css/simple.css"
	media="screen" />
<link rel="stylesheet" type="text/css" href="css/style.css"
	media="screen" />

<style>
.btn {
	font-family: Arial;
	color: #000000;
	font-size: 28px;
	text-decoration: none;
}
</style>

<script>
	function displayMessage3(text, style) {
		_$("message").innerHTML = "<p class='" + (style || "ok") + "'>" + text
				+ "</p>";
	}

	function test() {
		displayMessage("testtest");
	}

	var editableGrid = null;
var metadata ;
var data ;
	function loadXML() {
		editableGrid = new EditableGrid("DemoGridSimple", {

			// called when some value has been modified: we display a message
			modelChanged : function(rowIdx, colIdx, oldValue, newValue, row) {
				displayMessage( "Row "+this.getValueAt(rowIdx, 0)+" Column "+colIdx+" value changed!!Old Value was [" + oldValue + "] New value is ["
						+ newValue + "]");
			},
			tableRendered : function() {
				this.updatePaginator();
			}
			
			
		//rowSelected: function(oldRowIndex, newRowIndex) {if (oldRowIndex != newRowIndex) displayMessage("Editing MessageID '" + editableGrid.getValueAt(newRowIndex, 0) + "'");}
		});

		// load XML file
		//editableGrid.loadXML("grid.xml"); 

	<%
	String []tableD=null;
	String metaData="";
	String data="";
		if (session != null) {
			if (session.getAttribute("user") != null) 
				{
				String name = (String) session.getAttribute("user");
				
				tableD=DataController.readFromFile();
				 metaData=tableD[0];
				 data=tableD[1];
			} else {
				response.sendRedirect("index.jsp");
			}
		}
	%>
		 metadata =<%out.print(metaData);%>;
	
	
		 data = <%out.print(data);%>;
		 
		//editableGrid = new EditableGrid("DemoGridJsData");
		editableGrid.load({
			"metadata" : metadata,
			"data" : data
		});
		
		editableGrid.setPageSize(5);

		//editableGrid.setCellRenderer("action", new CellRenderer({render: function(cell, value) { 
		//			cell.innerHTML = "<a onclick=\"if (confirm('Are you sure you want to delete this person abc ? ')) editableGrid.remove(" + cell.rowIndex + ");\" style=\"cursor:pointer\">" +
		//							 "<img src=\"delete.png\" border=\"0\" alt=\"delete\" title=\"delete\"/></a>";
		//		}})); 
		editableGrid
				.setCellRenderer(
						"English",
						new CellRenderer(
								{
									render : function(cell, value) {
										cell.innerHTML = "<audio controls style=\"height:40px; width:70px;\"><source src=\"audio/enu/"
												+ editableGrid.getValueAt(
														cell.rowIndex, 0)
												+ ".vox\" type=\"audio/wav\">Your browser does not support the audio element.</audio>";
									}
								}));
		editableGrid
				.setCellRenderer(
						"French",
						new CellRenderer(
								{
									render : function(cell, value) {
										cell.innerHTML = "<audio controls style=\"height:40px; width:70px;\"><source src=\"audio/fra/"
												+ editableGrid.getValueAt(
														cell.rowIndex, 0)
												+ ".vox\" type=\"audio/wav\">Your browser does not support the audio element.</audio>";
									}
								}));
		editableGrid
						.setCellRenderer(
								"Action",
								new CellRenderer(
										{
											render : function(cell, value) {
												
												cell.innerHTML = "<button onclick=\"editButtonClick("+cell.rowIndex+","+cell.columnIndex+")\">Edit</button>"+"<button>TBD</button>  ";
											}
										}));
								
		
		
		
		// set active (stored) filter if any
		document.getElementById('filter').value = editableGrid.currentFilter ? editableGrid.currentFilter : '';

		// filter when something is typed into filter
		document.getElementById('filter').onkeyup = function() { editableGrid.filter(document.getElementById('filter').value); };
		document.getElementById("pagesize").onchange=function() { editableGrid.setPageSize(document.getElementById("pagesize").value); };
		editableGrid.isEditable = function(rowIndex, columnIndex) {
			
			//return rowIndex==1&&columnIndex==1;
			return true;
		};
		
		editableGrid.renderGrid("tablecontent", "testgrid");
	}
		
	// start when window is loaded
	window.onload = loadXML;
</script>




<script>
	function redirect() {
		var fname = document.getElementById("file_id").value;
		// check if fname has the desired extension
		console.debug("fasdfds");
		console.debug(fname);
		if (fname.endsWith(".wav") || fname.endsWith(".vox")) {

			document.getElementById('my_form').target = 'my_iframe';
			document.getElementById('my_form').submit();
		} else {
			displayMessage("Error file format!!", "rederror");
		}

	}
	function displayMessage(text, style) {
		document.getElementById("msg_input_id").value = text;
		document.getElementById("msg_input_style").value = style || "ok";

		document.getElementById('display_msg').target = 'my_iframe';
		document.getElementById('display_msg').submit();
		
		
		
	}

	function callJava(parameter) {
		console.debug("callJava entered with " + parameter);
		var a = editableGrid.getRowValues(0);
		
		document.getElementById("java_msg_name").value = parameter;
		var datavalue = [];
		var dataT=editableGrid.data;
		if(editableGrid.dataUnfiltered!=null){
			 dataT=editableGrid.dataUnfiltered;
		}
		
		
		for (i = 0; i < dataT.length; i++) {			
			var t_id=dataT[i].id;
			var t_col=dataT[i].columns;
				datavalue.push({"id":t_id,"values":t_col});	
		}
		//console.debug(editableGrid);

		document.getElementById("java_msg_data").value = JSON.stringify(datavalue);
		document.getElementById("java_msg_metadata").value=JSON.stringify(metadata);

		document.getElementById('java_call').target = 'my_iframe';
		document.getElementById('java_call').submit();
	}
	
		

</script>


</head>
<body>


	<div id="wrap" style="width: 1196px; margin: 0px auto;">
		
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
				<li class="active"><a href="home.jsp">Messages</a>
				<ul>
					<li><a href="home.jsp">All Messages</a></li>
					<li><a href="home.jsp">Edit Message</a></li>

				</ul>
				</li>
			<li><a href="#">User Admin</a>
				<ul>
					<li><a href="#">Manage Users</a></li>
					<li><a href="#">Add User</a></li>

				</ul></li>
			<li><a href="#">Tools</a>
				<ul>
					<li><a href="recorder.jsp">AudioRecorder</a></li>
					<li><a href="recorder.jsp">Audio Converter</a></li>
				</ul></li>
			<li><a href="#">Help</a>
				<ul>
					<li><a href="#">Help</a></li>
					<li><a href="#">About</a></li>

				</ul></li>
		</ul>


		<br> <br>
		<iframe id='my_iframe' name='my_iframe' width="850" height="25"
			style="border: none;" src=""> </iframe>
		<div id="message"></div>

		
		<!--
		<button onclick="callJava('saveTable')"  title="Save changes" class ="saveButton">Save Changes</button>
		<button onclick="callJava('saveTable')" title="Clear all temperoray changes" class ="clearButton">Clear Changes does not yet work</button>
		-->
		<input type="text" id="filter" class ="filterInput"/>
		<label for="filter" class ="filterLabel">Filter :</label> 
		
		<div id="pagecontrol">
				<label for="pagecontrol">Rows per page: </label>
				<select id="pagesize" name="pagesize">
					<option value="5">5</option>
					<option value="10">10</option>
					<option value="25">25</option>
					<option value="50">50</option>
					<option value="100">100</option>
				</select>
				
			</div>
		
		<!-- Grid contents -->
		<div id="tablecontent"></div>
		<!-- Feedback message zone -->

		<div id="paginator"></div>
		

		<!-- The Modal -->
		<div id="myModal" class="modal">

		  <!-- Modal content -->
		  <div id ="modal_content_id" class="modal-content">
			
			
		  </div>
		<!--
		<form id="my_form" action="UploadFile.jsp" method="post"
		enctype="multipart/form-data">
		<input id="file_id" type="file" name="file" accept=".wav,.vox"
			size="50" /> <input type="button" name="action" value="Upload"
			onclick="redirect()" />
			
			-->
	</form>

	<form id="recording_upload" action="UploadFile.jsp" method="post"
		enctype="multipart/form-data">
		<input id="recording_file_id" type="hidden" name="file" accept=".wav,.vox"
			size="50" /> 
	</form>


	<form id="display_msg" action="display.jsp" method="post">

		<input id="msg_input_id" type="hidden" name="msg_value"
			value="default" /> <input id="msg_input_style" type="hidden"
			name="msg_style" value="ok" />

	</form>

	<form id="java_call" action="WebController.jsp" method="post">

		<input id="java_msg_name" type="hidden" name="java_msg_name"
			value="default" /> <input id="java_msg_data" type="hidden"
			name="java_msg_data" value="" /><input id="java_msg_metadata" type="hidden"
			name="java_msg_metadata" value="" />

	</form>



	
	<br>
	<br>
	<form id="logout_form" action="Logout" method="post">
		<input type="hidden" value="Logout">
	</form>

	
	
	</div>


<script>
// Get the modal
var modal = document.getElementById('myModal');






function editButtonClick(row,col){
	displayMessage( "You are Editing row "+editableGrid.getValueAt(row, 0));
	modal.style.display = "block";
	
	var modal_content=document.getElementById('modal_content_id');
	modal_content.innerHTML="<span class=\"close\">&times;</span><p>This will be editing window coming soon! right now you are editing row "+editableGrid.getValueAt(row, 0)+"</p><br>"+
	"<p>English Clip is</p><br><audio controls style=\"height:40px;\"><source src=\"audio/enu/"+ editableGrid.getValueAt(row, 0)+ ".vox\" type=\"audio/wav\">Your browser does not support the audio element.</audio><br>"+
	
	"<p>French Clip is</p><br><audio controls style=\"height:40px;\"><source src=\"audio/fra/"+ editableGrid.getValueAt(row, 0)+ ".vox\" type=\"audio/wav\">Your browser does not support the audio element.</audio><br>"+
	"<p>Activation Date Time:</p> Date:<input type=\"date\" name=\"bday\" value=\"2018-02-06\"> Time: <input type=\"time\" value=\"15:59\" name=\"btime\">"+
	"<br><br><br><br>"+
	"<form id=\"my_form\" action=\"UploadFile.jsp\" method=\"post\""+
		"enctype=\"multipart/form-data\">"+
		"<input id=\"file_id\" type=\"file\" name=\"file\" accept=\".wav,.vox\""+
			"size=\"50\" /> <input type=\"button\" name=\"action\" value=\"Upload\""+
			"onclick=\"redirect()\" />";
			
		// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];



	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		modal.style.display = "none";
	}

}

</script>

	

</body>
</html>