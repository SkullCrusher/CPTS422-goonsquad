package goon_squad1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.ResultSet;

public class Receipts_Manager extends HttpServlet{	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		// TODO Auto-generated method stub
		String response="{\"data\":[", comments, upload_date, store, receipt_date, filename;
		Number cost;
		Integer id, records=0;
		
		try{
			String query = "SELECT * FROM receipts WHERE `created_user_id` = "+req.getParameter("user_id");
			ResultSet rs = MYSQLHACKS.DoQuery(query);
			while(rs.next()){
				if(records>0){
					response+=", ";
				}
				records+=1;
				id = rs.getInt("id");
				upload_date = rs.getString("upload_date");
				receipt_date = rs.getString("receipt_date");
				cost = rs.getDouble("total_cost");
				store = rs.getString("store");
				comments = rs.getString("comments");
				filename = rs.getString("filename");
				response+="{\"id\": \""+id.toString()+"\", \"filename\": \""+filename+"\", \"upload_date\": \""+upload_date+"\", \"cost\": \""+cost.toString()+
						"\", \"store\": \""+store+"\", \"comments\": \""+comments+"\", \"receipt_date\": \""+receipt_date+"\"}";
			}
			response+="]}";
		} catch (Exception e){
			System.err.println(e);
		}
		resp.getWriter().println(response);
	}
}
