package goon_squad1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Item_Creator extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String existing_id = request.getParameterMap().containsKey("id") ? request.getParameter("id") : "";
		String item_name = request.getParameter("item_name");
        String item_value = request.getParameter("item_value");
        String description = request.getParameter("description");
        String receipt_id = request.getParameter("receipt_id"); 
        	// Insert the new receipt.
        if (existing_id.length()>0) {
        	MYSQLHACKS.DoUpdate("UPDATE items "
        			+ "SET item_name = \"" + item_name + "\", "
    					+ "item_cost = \"" + item_value + "\", "
    					+ "description = \"" + description + "\" "
						+ "WHERE id = "+ existing_id + ";");
        } else {
        	MYSQLHACKS.DoUpdate("INSERT INTO items (item_name, item_cost, description, "
    			+ "receipt_id) VALUES "
    			+ "('" + item_name + "', '" + item_value + "', '" + description + "', "
    					+ "'" + receipt_id + "');");
        }
    		// Send valid.
    	response.getWriter().println("{\"string\":\"Successful\"}");
	}
}

