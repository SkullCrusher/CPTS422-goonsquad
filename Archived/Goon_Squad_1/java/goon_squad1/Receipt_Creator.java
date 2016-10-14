package goon_squad1;

import java.io.IOException;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Receipt_Creator extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String filename = request.getParameter("filename");
        String receiptDate = request.getParameter("receiptDate");
        String store = request.getParameter("store");
        String totalCost = request.getParameter("totalCost");    
        String comments = request.getParameter("comments"); 
        String user_id = request.getParameter("user_id"); 
        DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm");
        Date date = new Date();
        Date rec_date = new Date();
        try {
			rec_date = df.parse(receiptDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        	// Insert the new receipt.
    	MYSQLHACKS.DoUpdate("INSERT INTO receipts (upload_date, store, total_cost, "
    			+ "comments, created_user_id, filename, receipt_date) VALUES "
    			+ "('" + df.format(date) + "', '" + store + "', '" + totalCost + "', "
    					+ "'" + comments + "', '" + user_id + "', '" + filename + "', "
    							+ "'" + df.format(rec_date) + "');");
    	
    		// Send valid.
    	response.getWriter().println("{\"string\":\"Successful\"}");
	}
}
