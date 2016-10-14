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
		<script type="text/javascript" src="resources/js/edit.js"></script>
		<script src="resources/thirdparty/jquery-simple-datetimepicker-1.12.0/jquery.simple-dtpicker.js"></script>
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="navbar.jsp"/>
	
	<div class="bread">
		<div class="nav-bar-960-bread-container">
	    
		    <div class="bread-crumbs">
		   		<a class="bread-root" href="index.jsp">HOME PAGE</a><a class="bread-root" href="view.jsp?id=<%= request.getParameter("id") %>"> > VIEW</a><a class="bread-child" href="#">> EDIT</a>
		    </div>
		    
		    <div class="bread-custom-buttons" style="float:right;">
		    	<input id="UpdateReciept" type="submit" value="Submit Changes"/>
		    	<input id="AddItemButton" type="submit" value="Add Item"/>
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
	<form id="ReceiptForm">
		<div id="receipt-title">Purchase Time:</div> <input type="text" id="ReceiptDate" name="purchaseTime" required/><br/>
		<div id="receipt-title">Store:</div>         <input type="text" id="store" name="store" required/><br/>
		<div id="receipt-title">Total Cost:</div>    <input type="text" id="totalCost" name="totalcost" required/><br/>
		<div id="receipt-title">Comments:</div>      <textarea id="comments" rows="4" cols="50" name="comments" ></textarea><br/>
	</form>
	<!-- <button id="UpdateReciept">Submit</button></br></br>
	<button id="AddItemButton">Add Item</button>-->
	<table id="itemsTable"  class="receipt-table display" style="width:100%">
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Value</th>
			<th>Description</th>
			<th>Edit</th>
			<th>Delete</th>
		</tr>
	</table>
	</div>
	<div id="submitItemDialog" title="Add Item">
		<form id="ItemForm">
			<fieldset id="manualFields" >
				Name: <input type="text" id="ItemName" name="name" required/><br/>
				Value:         <input type="text" id="value" name="value" required/><br/>
				Description: <textarea id="description" rows="4" cols="50" name="description" ></textarea><br/>
			</fieldset>
		</form>
	</div>	
</body>
</html>