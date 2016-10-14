package goon_squad1;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Items_Fetcher  extends HttpServlet{	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		// TODO Auto-generated method stub
		String response="{\"data\":[", item_name, description;
		Double item_cost;
		Integer id, records=0;
		Number cost;
		
		try{
			String query = "SELECT * FROM items WHERE `receipt_id` = "+req.getParameter("receipt_id");
			ResultSet rs = MYSQLHACKS.DoQuery(query);
			while(rs.next()){
				if(records>0){
					response+=", ";
				}
				records+=1;
				id = rs.getInt("id");
				item_name = rs.getString("item_name");
				item_cost = rs.getDouble("item_cost");
				description = rs.getString("description");
				response+="{\"id\": \""+id.toString()+"\", \"item_name\": \""+item_name+"\", \"item_cost\": \""+item_cost.toString()+"\","
						+ " \"description\": \""+description+"\"}";
			}
			response+="]}";
		} catch (Exception e){
			System.err.println(e);
		}
		resp.getWriter().println(response);
	}
}