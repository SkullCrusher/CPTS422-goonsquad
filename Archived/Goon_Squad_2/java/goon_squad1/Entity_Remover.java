package goon_squad1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Entity_Remover extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		String query = "DELETE FROM "+req.getParameter("table")+" WHERE id="+req.getParameter("id");
		resp.getWriter().println(MYSQLHACKS.DoUpdate(query));
	}
}
