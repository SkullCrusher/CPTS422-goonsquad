/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var dialog, table, user_id;
createReceiptsTable = function (baseUrl){
    var columnDefs = [{
        data: "id",
        visible: false
    }, {
        data: "filename",
        visible: false
    }, {
        data: "upload_date",
        sortable: true
    }, {
        data: "receipt_date",
        sortable: true
    }, {
        data: "store",
        sortable: true
    }, {
        data: "cost",
        sortable: true
    }, {
        data: "comments",
        sortable: true
    }, {
        data: null,
        sortable: false,
        render: function( data, type, row ){
        	return '<div data-fname="'+row['filename']+'" class="download-button fa fa-download" aria-hidden="true"></div>';
        }
    }, {
        data: null,
        sortable: false,
        render: function( data, type, row ){
        	return "<a href='view.jsp?id="+row['id']+"' class='fa fa-eye' aria-hidden='true'></i>";
        }
    }, {
        data: null,
        sortable: false,
        render: function( data, type, row ){
        	return "<a href='edit.jsp?id="+row['id']+"' class=\"fa fa-cog\" aria-hidden=\"true\"></a>";
        }
    }, {
        data: null,
        sortable: false,
        render: function( data, type, row ){
        	return '<div data-id="'+row['id']+'" class="delete-button fa fa-times-circle-o" aria-hidden="true"></div>';
        }
    }];
    
    var requestParams = {user_id: user_id};
    console.log(user_id);
    var config = {
        ajax: {
        	dataSrc: "data",
            type: "GET",
            url: baseUrl+"/fetchReceipts",
            data: requestParams,
            dataType : 'json'
            },
            
        "dom": '<"top"f>t<"bottom">irlp<"clear">',
         
        columns: columnDefs,
    };

    table = jQuery("#receipt-datatable").DataTable(config);
    createUploadReceiptDialog(baseUrl, table);
    
};

createUploadReceiptDialog = function(baseUrl, table){
	
	var valid = true;
	
	
    $( "#ReceiptDate" ).appendDtpicker({
    	"dateFormat": "MM/DD/YYYY hh:mm"
    });
    $('#ReceiptForm').validate({
        rules: {
        	purchaseTime: "required",
        	store: "required",
        	totalcost: {
        		required: true,
        		number: true,
        		min: 0
        		}
        },
        messages: {
        	purchaseTime: "Please enter the time of puchase.",
        	store: "Please enter the name of purchase location.",
        	totalcost:{ 
        		required: "Please enter the total cost of the purchase.",
        		number: "Value must be a valid decimal number.",
        		min: "Value must be a positive decimal number."}
        }
    });

	var dialog = $("#submitReceiptDialog").dialog({
		autoOpen: false,
	      modal: true,
	      height: 450,
	      width: 550,
	      buttons: {
		     "Submit": function() {
		    	 console.log($("#file-select").get(0).files[0]);
		    	 if( $('#ReceiptForm').valid()){
			    	 var filename = $("#file-select").get(0).files[0].name; 
			    	 var receiptDate = $("#ReceiptDate").val();
			    	 var store = $("#store").val();
			    	 var totalCost = $("#totalCost").val();
			    	 var comments = $("#comments").val();
			    	 var postdata = {filename: filename, receiptDate: receiptDate,
			    			 store: store, totalCost: totalCost, comments: comments,
			    			 user_id: user_id};
			    	 console.log(user_id);
			    	 $.ajax({
			    		type: "POST",
				    	url: baseUrl+"/createreceipt",
				    	data: postdata,
				    	success: function(){
				    		console.log("Receipt created successfully.");
				    	}
			    	 });
			    	 $("#ReceiptDate").val("");
			    	 $("#store").val("");
			    	 $("#totalCost").val("");
			    	 $("#comments").val("");
			    	 $(this).dialog( "close" );
			    	 table.ajax.reload();
		    	 }
	       },
		     "Close": function() {
		    	$(this).dialog( "close" );
		       }
	      }
	});

    addClickListeners(dialog, baseUrl, table);
}

addClickListeners = function(dialog, baseUrl, table){
	var file;
	$("#UploadButton").on("click", function(){
		dialog.dialog("open");
	});
	$("#fileUploadButton").on("click", function(e){//$("#file-select").change( function(){
		var fileField = $("#file-select").get(0);
		file = fileField.files[0];
		if($("#file-select").val()&&file.type=="application/pdf"){
			var data = new FormData();//{"file": file.toString()};
			data.append("file", file);
			console.log(data);
			$.ajax({
				url: baseUrl+"/upload",
				type: "POST",
				data: data,
			    contentType: false,
			    processData: false,
				success: function(){
					$("#manualFields").prop("disabled", false);
				},
				error: function(){}
			});
		} else if ($("#file-select").val()){//we know file extension was the problem
			$("#manualFields").prop("disabled", true);
			alert("File upload must be PDF.");
		} else {
			$("#manualFields").prop("disabled", true);
		}
	});
	$("#receipt-datatable").on("click", "tbody tr td div.delete-button", function(e){
		if(confirm("Are you sure you want to delete this receipt and all its data?")){
			var data = {id: $(this).data('id'), table: "receipts"};
			$.ajax({
				type: "POST",
				url: baseUrl+"/deleteentity",
				data: data,
				success: function(){
					console.log("Receipt deleted successfully");
					table.ajax.reload();
				}
			});
		}
	});
	$("#receipt-datatable").on("click", "tbody tr td div.download-button", function(e){
		var data = {filename: $(this).data('fname')};
		window.location = baseUrl+"/download?filename="+$(this).data('fname');
	});
}

getUserId = function(baseUrl){

	$.ajax( {
		type: "POST",
	    url: baseUrl+"/sessioncheck",
	    data: requestParams,
	    dataType : 'json',
		success: function( data ){
			user_id =data.id;
			createReceiptsTable(baseUrl);
		}
	});
	var data = {user_id: user_id, table: table};
	return data;
}

$("document").ready(function(){
	var dialogForm=$("div.reciept-button-container");
	var getUrl = window.location;
	var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    getUserId(baseUrl);
    
    
    $(document).on({
        ajaxStart: function() { dialogForm.addClass("loading");    },
         ajaxStop: function() { dialogForm.removeClass("loading"); }    
    });
});
