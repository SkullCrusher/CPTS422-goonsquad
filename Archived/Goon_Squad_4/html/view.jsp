<%-- 
    Document   : view
    Created on : Sep 3, 2016, 6:46:16 PM
    Author     : Sheldon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    	<link rel="stylesheet" type="text/css" href="resources/css/default.css">
	<link rel="stylesheet" type="text/css" href="resources/thirdparty/font-awesome.css">
	<link href="https://fonts.googleapis.com/css?family=Concert+One" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet"> 
	<link href="https://fonts.googleapis.com/css?family=Unica+One" rel="stylesheet"> 
	<link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet"> 
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.2.1/css/buttons.dataTables.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.2.0/css/select.dataTables.min.css">
	<link rel="stylesheet" type="text/css" href="https://editor.datatables.net/extensions/Editor/css/editor.dataTables.min.css">

	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/select/1.2.0/js/dataTables.select.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.2.1/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="https://editor.datatables.net/extensions/Editor/js/dataTables.editor.min.js"></script>
    </head>
    <body>

	<jsp:include page="navbar.jsp"/>
	
	<div class="view-receipt-container">
            <button class="view-receipt-edit-button">
		Add New
            </button>	
            <button class="view-receipt-edit-button">
            	Edit Existing
            </button>		
		
            <button class="view-receipt-save-button">
		Save Edits
            </button>
				
            <div class="view-receipt-information-container">		
		<table id="example" class="display" cellspacing="0" width="100%">
                    <thead>
			<tr>
                            <th>ID</th>
                            <th>Information</th>
                            <th>Value</th>
                            <th>Delete</th>						
			</tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>January</td>
                            <td>$100</td>
                            <td>$100</td>
                            <td>$100</td>	
			</tr>
                    </tbody>
		</table>		
            </div>		
	</div>
	
	<script>
	
	//https://editor.datatables.net/examples/inline-editing/simple
	
	var editor; // use a global for the submit and return data rendering in the examples
	 
	$(document).ready(function() {
		editor = new $.fn.dataTable.Editor( {
			//ajax: "../php/staff.php",
			table: "#example",
			fields: [ {
					label: "ID",
					name: "id"
				}, {
					label: "Information",
					name: "information"
				}, {
					label: "Value",
					name: "value"
				}
			]
		} );
	 
		// Activate an inline edit on click of a table cell
		$('#example').on( 'click', 'tbody td:not(:first-child)', function (e) {
			editor.inline( this );
		} );
	 
		$('#example').DataTable( {
			dom: "Bfrtip",
			/*ajax: "../php/staff.php",*/
			columns: [
				{
					data: null,
					defaultContent: '',
					className: 'select-checkbox',
					orderable: false
				},
				{ data: "id" },
				{ data: "information" },
				{ data: "value", render: $.fn.dataTable.render.number( ',', '.', 0, '$' ) }
			],
			select: {
				style:    'os',
				selector: 'td:first-child'
			},
			buttons: [
				{ extend: "create", editor: editor },
				{ extend: "edit",   editor: editor },
				{ extend: "remove", editor: editor }
			]
		} );
	} );
		
	</script>	
</html>