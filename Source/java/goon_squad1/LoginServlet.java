package goon_squad1;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    		// Get the user submitted username and password.
        String username = request.getParameter("username").toLowerCase();
        String password = request.getParameter("password");

        	// Look up the user's password.
    	ResultSet a = MYSQLHACKS.DoQuery("SELECT password FROM users WHERE username='" + username + "';");
    	
    	
    	
    		// Check if the user exists.    	
    	if(a == null){
    		
    			// Not a valid user, print a error. 
    		response.getWriter().println("{\"string\": \"Error\"}");
    		
    		return;
    	}
    	
    	
    		// The user Exists so attempt to match the password.    	
    	boolean PasswordsMatch = false;
    	
    	try {
			while(a.next()){				
				if(password.equals(a.getString("password"))){
					PasswordsMatch = true;
				}
			}
		} catch (SQLException e) {}
    	
    	
    		// If the password matches.
    	if(PasswordsMatch){
    		
    			// Save to session.
    		HttpSession session = request.getSession();
    		session.setAttribute("LoggedIn_username", username);
    		
    			// Print success.   		
    		response.getWriter().println("{\"string\": \"Correct\"}");
    		
    		return;
    	}else{
    		
    			// Save to session.
    		HttpSession session = request.getSession();
    		session.setAttribute("LoggedIn_username", " ");
    		
    			// Print error.
    		response.getWriter().println("{\"string\": \"Error\"}");
    	    		
    		return;
    	} 	
     }

}