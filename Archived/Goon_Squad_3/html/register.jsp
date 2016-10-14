<%-- 
    Document   : register
    Created on : Sep 3, 2016, 6:46:08 PM
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
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="resources/thirdparty/md5.js"></script>
    </head>
    <body>

        <jsp:include page="navbar.jsp"/>
        
    <div class="bread">
		<div class="nav-bar-960-bread-container">
	    
		    <div class="bread-crumbs">
		   		<a class="bread-root" href="index.jsp">HOME PAGE</a><a class="bread-child" href="register.jsp">> REGISTER</a>
		    </div>
		    
		    <div class="bread-custom-buttons" style="float:right;"></div>
	    </div>
	</div>

        <div class="register-dialog-container">	
            <div class="register-dialog">

            <div id="register-header">Register</div>

            <div class="register-form">
                <label for="username">Username</label><br>
                <input type="textbox" id="username"></input><br>

                <label for="password">Password</label><br>
                <input type="password" id="password"></input><br>

                <label for="password2">Repeat Password</label><br>
                <input type="password" id="password2"></input><br>

                <input type="submit" id="register-submit" value="Create a new account">
            </div>	
            
            <div id="register-login-to-account"> Have an account? <a href="login.jsp">Login</a> </div>	
        </div>
    </body>		
    
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
 				$(location).attr('href', baseUrl+"/index.jsp");
 			}
 		}
 	});
 
    $( "#register-submit" ).click(function() {
    	 // alert( "Handler for .click() called." );
    	  
    	  var getUrl = window.location;
    		var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    		
    		var Username = $('#username').val();
    		var Password = $('#password').val();
    		var Password2 = $('#password2').val();
    	
    	    var requestParams = {"username": Username, "password": md5(Password), "password2": md5(Password2)};

    	    $.ajax( {
    	    	type: "POST",
    	        url: baseUrl+"/registerUser",
    	        data: requestParams,
    	        dataType : 'json',
    	    	success: function( data ){
    	    		
    	    		if (data.string.indexOf("Passwords do not match") >= 0){
    					alert("Passwords do not match.");
    	    			return;
    	    		}
    	    		
    	    		if (data.string.indexOf("Pick another username") >= 0){
        				alert("Username is taken, please pick another.");
    	    			return;
    	    		}
    					
    				    	    		
    	    		if (data.string.indexOf("Successful") >= 0){        				
    	    			$(location).attr('href', baseUrl+"/index.jsp");    	    			
    	    			return;
    	    		}
    	    		
 
    	    	}
    	    })
    	      	      	  
    });
    </script>
    
</html>
