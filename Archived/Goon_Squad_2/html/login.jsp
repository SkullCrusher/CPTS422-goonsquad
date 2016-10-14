<%-- 
    Document   : login
    Created on : Sep 3, 2016, 6:45:52 PM
    Author     : Sheldon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <link rel="stylesheet" type="text/css" href="resources/css/default.css">
        <link rel="stylesheet" type="text/css" href="resources/thirdparty/font-awesome.css">
        <link href="https://fonts.googleapis.com/css?family=Concert+One" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Unica+One" rel="stylesheet"> 
        <link href="https://fonts.googleapis.com/css?family=Quicksand" rel="stylesheet">  
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet"> 
        <link href="https://fonts.googleapis.com/css?family=Dosis" rel="stylesheet"> 
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
		   		<a class="bread-root" href="index.jsp">HOME PAGE</a><a class="bread-child" href="login.jsp">> LOGIN</a>
		    </div>
		    
		    <div class="bread-custom-buttons" style="float:right;"></div>
	    </div>
	</div>

    <div class="login-dialog-container">	
        <div class="login-dialog">
		
            <div id="login-header">Login</div>
			
            <div class="login-form">
                <label for="username">Username</label><br>
                <input type="textbox" id="username"></input><br>
				
                <label for="password">Password</label><br>
                <input type="password" id="password"></input><br>
                
                <input type="submit" id="login-submit" value="Login">
            </div>	
            
            <div id="login-register-for-account"> Don't have an account? <a href="register.jsp">Register</a> </div>	
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
  
    
    
    	// On user click try to login and if successful redirect.
    $( "#login-submit" ).click(function() {
    	  
    	  	var getUrl = window.location;
    		var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    		
    		var Username = $('#username').val();
    		var Password = $('#password').val();
    	
    	    var requestParams = {"username": Username, "password": md5(Password)};

    	    $.ajax( {
    	    	type: "POST",
    	        url: baseUrl+"/loginUser",
    	        data: requestParams,
    	        dataType : 'json',
    	    	success: function( data ){
    	    		
    	    		if (data.string.indexOf("Error") >= 0){
    	    			alert( "Error with login: Please try again." );
    	    		}else{    	    			
    	    			$(location).attr('href', baseUrl+"/index.jsp");
    	    		}
    	    	}
    	    });
    });
    </script>
    		
</html>