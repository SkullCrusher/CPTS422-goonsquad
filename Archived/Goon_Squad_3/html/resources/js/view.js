/**
 * 
 */

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
            
            "dom": '<"top"f>t<"bottom">irlp<"clear">',
            
         
        columns: columnDefs,
    };

    return jQuery("#itemsTable").DataTable(config);
}

function getURLParameter(name) {
	  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
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

$("document").ready(function(){
	var url = window.location.pathname;
	var id = getURLParameter('id');
	var getUrl = window.location;
	var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
	getReceiptInfo(baseUrl, id);
    var table = createItemsTable(baseUrl, id);
});