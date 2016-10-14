package goon_squad1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;

public class MYSQLHACKS {

	static public ResultSet DoQuery(String query) throws ServletException, IOException {
				
		try{
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost/goon_squad?"+
							//"user=root";
							"user=goon_squad&password=goon_squad2016@#$$Bills";
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url);
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
		
			return rs;			
		} catch (Exception e){
			System.err.println(e);
		}
		
		
		return null;
	}
	
	
	static public int DoUpdate(String query) throws ServletException, IOException {
		
		try{
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost/goon_squad?"+
							//"user=root";
							"user=goon_squad&password=goon_squad2016@#$$Bills";
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url);
			Statement st = conn.createStatement();
			int rs = st.executeUpdate(query);
		
			return rs;			
		} catch (Exception e){
			System.err.println(e);
		}
		
		
		return 0;
	}
	
	
}
