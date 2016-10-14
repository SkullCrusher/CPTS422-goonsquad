<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="resources/css/default.css">
		<link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel='stylesheet'>
		<link rel="stylesheet" type="text/css" href="resources/thirdparty/font-awesome.css">
		<link href="https://fonts.googleapis.com/css?family=Concert+One" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Unica+One" rel="stylesheet"> 
		<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet"> 
		
  		<link rel="stylesheet" type="text/css" href="resources/thirdparty/jquery-simple-datetimepicker-1.12.0/jquery.simple-dtpicker.css">
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">		
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.js"></script>
		<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.js"></script>
 		<script type="text/javascript" src="http://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.js"></script>
		<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>
  		<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
		<script type="text/javascript" src="resources/js/view.js"></script>
		<script src="resources/thirdparty/jquery-simple-datetimepicker-1.12.0/jquery.simple-dtpicker.js"></script>
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="navbar.jsp"/>
	
	<div class="bread">
		<div class="nav-bar-960-bread-container">
	    
		    <div class="bread-crumbs">
		   		<a class="bread-root" href="index.jsp">HOME PAGE</a><a class="bread-child" href="#">> VIEW</a>
		    </div>
		    
		    <div class="bread-custom-buttons" style="float:right;">
		    	<input id="DownloadButton" type="submit" value="Download Receipt" style="display:none;"/>
		    	<a id="EditButton" type="submit" href="edit.jsp?id=<%= request.getParameter("id") %>"/>Edit Receipt</a>
		    	
		    </div>
	    </div>
	</div>
	
	<div id="top-little-fake-bar-thing">
		<div class="fake-bar-header">
			Receipt
		</div>
		
		<div class="fake-bar-subtext">
			This is the data on a single <br>
			receipt that was uploaded.
		</div>
	</div>
	
	<div class="content">
		<form id="ReceiptForm" disabled="true">
			Purchase Time: <input type="text" id="ReceiptDate" name="purchaseTime" readonly/><br/>
			Store:         <input type="text" id="store" name="store" readonly/><br/>
			Total Cost:    <input type="text" id="totalCost" name="totalcost" readonly/><br/>
			Comments: <input id="comments" rows="4" cols="50" name="comments" readonly/><br/>
		</form>
		<table id="itemsTable"  class="receipt-table display" style="width:100%">
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Value</th>
				<th>Description</th>
			</tr>
		</table>
	</div>
	
  <script>
//JavaScript to force redirect.
	var requestParams = {};
	
	var getUrl = window.location;
	var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
	
	$.ajax( {
		type: "POST",
	    url: baseUrl+"/sessioncheck",
	    data: requestParams,
	    dataType : 'json',
		success: function( data ){
			
			if (data.string.indexOf("Error") >= 0){
				$(location).attr('href', baseUrl+"/login.jsp");
			}
		}
	});
	</script>
</body>
</html>