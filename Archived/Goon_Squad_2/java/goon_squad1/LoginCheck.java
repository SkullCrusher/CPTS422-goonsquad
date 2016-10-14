package goon_squad1;


import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 	// JavaScript to force redirect.
  <script>

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
    
 */


public class LoginCheck extends HttpServlet {
	
	 @Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		 	// Handle logout
		String logout = request.getParameter("logout");
				
		if(logout instanceof String && logout.length() >= 1){
			//System.out.println("Logout");
				// Log out.
			HttpSession session = request.getSession();
	 		session.setAttribute("LoggedIn_username", "");
	 		
	 		response.getWriter().println("{\"string\": \"Logged out\"}"); 
	 		
		}else{
			
				// Check if logged in and if so return username.		 
			HttpSession session = request.getSession();
	 		Object Result = session.getAttribute("LoggedIn_username");
	 		
	 		if(Result instanceof String){ 		
		 		if(((String)Result).length() < 1){ 		
		 			response.getWriter().println("{\"string\": \"Error\"}"); 	
		 		}else{
		 			
		 				// Look up the user's password.
		 	    	ResultSet a = MYSQLHACKS.DoQuery("SELECT id FROM users WHERE username='" + ((String)Result) + "';");
		 	    	
		 	    	//{"string": "asd", "asd": "dsaf"}
		 			
		 			try {
						response.getWriter().println("{\"string\": \"" + ((String)Result) + "\", \"id\": \"" + a.getString("id") + "\"}");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 	
		 		}
	 		}else{
	 			response.getWriter().println("{\"string\": \"Error\"}"); 
	 		}
		}
	 }	 
}
