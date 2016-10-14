<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="nav-bar">
	<div class="nav-bar-960-container">		
	    <div class="nav-bar-group-name">
	    	<img id="sickasslion" src="resources/img/sickasslion.png" height="54" width="50"> 	    	
	    	<div id="nav-group-name-text">
	    		<a href="index.jsp">Goon Squad</a>
	    	</div>	    	
	    </div>	    
	    <div class="nav-bar-account-container">
			Logged in as: Goon Squad <a id="logout" href="#">(Log out)</a>
	    </div>	    
    </div>    
</div>

<div class="bread">
	<div class="nav-bar-960-bread-container">
    
	    <div class="bread-crumbs">
	   		<a class="bread-root" href="index.jsp">HOME PAGE</a><a class="bread-child" href="#">> LOGIN</a>
	    </div>
	    
	    <div class="bread-custom-buttons" style="float:right;"></div>
    </div>


</div>


<script>
		// If the user is already logged in force them to the index.htm
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
			}else{
				$(".nav-bar-account-container").html("Logged in as: " + data.string + " <a id=\"logout\" href=\"#\">(Log out)</a>");	
			
				// On click, logout.
				$( "#logout" ).click(function() {
				 // alert( "Handler for .click() called." );
				  
				  var requestParams = {"logout" : "yes please ;)"};
					
				  var getUrl = window.location;
				  var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
					
					$.ajax( {
						type: "POST",
					    url: baseUrl+"/sessioncheck",
					    data: requestParams,
					    dataType : 'json',
						success: function( data ){					
							$(location).attr('href', baseUrl+"/login.jsp");
						}
					});
				  
				});
			}
		}
	});
	
	// On click, logout.
	$( "#logout" ).click(function() {
	  alert( "Handler for .click() called." );
	  
	  var requestParams = {"logout" : "yes please ;)"};
		
	  var getUrl = window.location;
	  var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
		
		$.ajax( {
			type: "POST",
		    url: baseUrl+"/sessioncheck",
		    data: requestParams,
		    dataType : 'json',
			success: function( data ){					
				$(location).attr('href', baseUrl+"/login.jsp");
			}
		});
	  
	});
	
</script>