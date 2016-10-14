package goon_squad1;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username").toLowerCase();
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
                        
        	// Server side check that the passwords match.
        if(password.equals(password2) == false){
        	response.getWriter().println("{\"string\":\"Passwords do not match.\"}");
        	
        	return;
        }        
        
    		// Look up to see if the account is already made.
    	ResultSet databasecheck = MYSQLHACKS.DoQuery("SELECT * FROM users WHERE username='" + username + "';");
    	
    	
    	boolean Username_used = false;
    	
    	try {
			while(databasecheck.next()){				
				if(username.equals(databasecheck.getString("username"))){
					Username_used = true;
				}
			}
		} catch (SQLException e) {}
    	
    	//if(databasecheck != null){
    	if(Username_used){
    		response.getWriter().println("{\"string\":\"Pick another username.\"}");
    		
    		return;
    	}
        
        	// Insert the new account.
    	MYSQLHACKS.DoUpdate("INSERT INTO users (username, password) VALUES ('" + username + "', '" + password + "');");
    	
    		// Send valid.
    	response.getWriter().println("{\"string\":\"Successful\"}");
    	
    		// Save to session.
    	HttpSession session = request.getSession();
    	session.setAttribute("LoggedIn_username", username);
    	
    }

}