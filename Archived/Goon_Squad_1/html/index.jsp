<html>
	<head>
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
		<script type="text/javascript" src="resources/js/index.js"></script>
  		<script src="resources/thirdparty/jquery-simple-datetimepicker-1.12.0/jquery.simple-dtpicker.js"></script>
	</head>
	<body>

	<jsp:include page="navbar.jsp"/>
	
	<div class="content">

	    <input id="UploadButton" type="submit" value="Upload Receipt"/>
	    <br/><br/>
		<table id="receipt-datatable" class="receipt-table display" style="width:100%">
			<thead>
				<tr>
					<th>ID</th>	
					<th>Filename</th>			
					<th>Upload Date</th>
					<th>Purchase Date</th>
					<th>Store</th>
					<th>Total Cost</th>
					<th>Description</th>
					<th>Download</th>
					<th>View</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
		</table> 
	</div>
	<div id="submitReceiptDialog" title="Upload New Receipt">
		<form id="ReceiptForm">
			<div class="reciept-button-container">
				File: <input id="file-select" name="file" type="file" /><div class="modal"></div><br/>
				<input id="fileUploadButton" type="submit" value="Upload File"/>
			</div>
			<fieldset id="manualFields" disabled="disabled">
				Purchase Time: <input type="text" id="ReceiptDate" name="purchaseTime" required/><br/>
				Store:         <input type="text" id="store" name="store" required/><br/>
				Total Cost:    <input type="text" id="totalCost" name="totalcost" required/><br/>
				Comments: <textarea id="comments" rows="4" cols="50" name="comments" ></textarea><br/>
			</fieldset>
		</form>
	</div>	
	</body>	
</html>