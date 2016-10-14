/**
 * 
 */
var existing_id=-1;

createItemsTable = function (baseUrl, id){
    var columnDefs = [{
        data: "id",
        visible: false
    }, {
        data: "item_name",
        sortable: true
    }, {
        data: "item_cost",
        sortable: true
    }, {
        data: "description",
        sortable: true
    }, {
        data: null,
        sortable: false,
        render: function( data, type, row ){
        	return "<i data-id='"+row['id']+"' class=\"edit-button fa fa-cog\" aria-hidden=\"true\"></i>";
        }
    }, {
        data: null,
        sortable: false,
        render: function( data, type, row ){
        	return '<div data-id="'+row['id']+'" class="delete-button fa fa-times-circle-o" aria-hidden="true"></div>';
        }
    }];
    
    var requestParams = {receipt_id: id};

    var config = {
        ajax: {
        	dataSrc: "data",
            type: "GET",
            url: baseUrl+"/fetchItems",
            data: requestParams,
            dataType : 'json'
            },
         
        columns: columnDefs,
    };

    return jQuery("#itemsTable").DataTable(config);
}

createItemDialog = function(baseUrl, table, id){
	
	var valid = true;
	
    $('#ItemForm').validate({
        rules: {
        	name: "required",
        	value: {
        		required: true,
        		number: true,
        		min: 0
        		}
        },
        messages: {
        	name: "Please enter the name of the item.",
        	value: { 
        		required: "Please enter the price of the item.",
        		number: "Value must be a valid decimal number.",
        		min: "Value must be a positive decimal number."}
        }
    });

	var dialog = $("#submitItemDialog").dialog({
		autoOpen: false,
	      modal: true,
	      height: 400,
	      width: 550,
	      buttons: {
		     "Submit": function() {
		    	 if( $('#ItemForm').valid()){ 
			    	 var name = $("#ItemName").val();
			    	 var value = $("#value").val();
			    	 var description = $("#description").val();
			    	 var postdata = {item_name: name, item_value: value,
			    			 description: description, receipt_id: id};
			    	 if(existing_id>0){
			    		 postdata["id"]= existing_id;
		    	 		}
			    	 console.log(postdata);
			    	 $.ajax({
			    		type: "POST",
				    	url: baseUrl+"/createitem",
				    	data: postdata,
				    	success: function(){
				    		console.log("Item created successfully.");
				    	}
			    	 });
			    	 existing_id=-1;
			    	 $(this).dialog( "close" );
			    	 $("#ItemName").val("");
			    	 $("#value").val("");
			    	 $("#description").val("");
			    	 table.ajax.reload();
		    	 }
	       },
		     "Close": function() {
		    	$(this).dialog( "close" );
		       }
	      }
	});
	return dialog;
}

addClickListeners = function(dialog, baseUrl, table, id){
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
	$("#AddItemButton").on("click", function(){
		dialog.dialog("open");
	});
	$("#itemsTable").on("click", "tbody tr td i.edit-button", function(){
		tds = $(this).closest("tr").children("td");
		console.log(tds[0]);
	   	 $("#ItemName").val(tds[0].textContent);
		 $("#value").val(tds[1].textContent);
		 $("#description").val(tds[2].textContent);
		 existing_id=$(this).data("id");
		 dialog.dialog("open");
	});
	$("#itemsTable").on("click", "tbody tr td div.delete-button", function(e){
		if(confirm("Are you sure you want to delete this receipt and all its data?")){
			var data = {id: $(this).data('id'), table: "items"};
			$.ajax({
				type: "POST",
				url: baseUrl+"/deleteentity",
				data: data,
				success: function(){
					console.log("Item deleted successfully");
					table.ajax.reload();
				}
			});
		}
	});
	$("#UpdateReciept").on("click", function(){
		 if( $('#ReceiptForm').valid()){
	    	 var receiptDate = $("#ReceiptDate").val();
	    	 var store = $("#store").val();
	    	 var totalCost = $("#totalCost").val();
	    	 var comments = $("#comments").val();
	    	 var postdata = {receiptDate: receiptDate,
	    			 store: store, totalCost: totalCost, comments: comments,
	    			 user_id: 1, id: id};
	    	 $.ajax({
	    		type: "POST",
		    	url: baseUrl+"/createreceipt",
		    	data: postdata,
		    	success: function(){
		    		console.log("Receipt updated successfully.");
		    	}
	    	 });
    	 }
	});
}

getReceiptInfo = function(baseUrl, id){
	 var postdata = {id: id};
	 $.ajax({
 		type: "GET",
	    	url: baseUrl+"/fetchReceipts",
	    	data: postdata,
	    	success: function(e){
	    		var array = $.parseJSON(e);
	    		console.log(e);
	    		console.log(array);
	    		$("#ReceiptDate").val(array.data[0]["receipt_date"]);
	    		$("#store").val(array.data[0]["store"]);
	    		$("#totalCost").val(array.data[0]["cost"]);
	    		$("#comments").val(array.data[0]["comments"]);
	    	}
 	 });
}

function getURLParameter(name) {
	  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
}

$("document").ready(function(){
	var url = window.location.pathname;
	var id = getURLParameter('id');
	var getUrl = window.location;
	var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
	getReceiptInfo(baseUrl, id);
    var table = createItemsTable(baseUrl, id);
    var dialog = createItemDialog(baseUrl, table, id);
    addClickListeners(dialog, baseUrl, table, id);
});