package goon_squad1;

import java.io.IOException;

import org.apache.commons.fileupload.FileItem;
import org.omg.CORBA.NameValuePair;

import sun.net.www.http.HttpClient;

import java.util.List;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class Receipt_Processor extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		  response.setContentType("text/html;charset=UTF-8");
		    // Create path components to save the file
		    final String path = "C:/Users/Jordan/workspace_ee/goon_squad1/uploads";//request.getParameter("destination");
		    final Part filePart = request.getPart("file");
		    final String fileName = getFileName(filePart);
		    OutputStream out = null;
		    InputStream filecontent = null;
		    final PrintWriter writer = response.getWriter();
		    try {
		        out = new FileOutputStream(new File(path + File.separator
		                + fileName));
		        filecontent = filePart.getInputStream();

		        int read = 0;
		        final byte[] bytes = new byte[1024];

		        while ((read = filecontent.read(bytes)) != -1) {
		            out.write(bytes, 0, read);
		        }
		    } catch (FileNotFoundException fne) {
		        writer.println("You either did not specify a file to upload or are "
		                + "trying to upload a file to a protected or nonexistent "
		                + "location.");
		        writer.println("<br/> ERROR: " + fne.getMessage());
		    } finally {
		        if (out != null) {
		        	out.close();
		        }
		        if (filecontent != null) {
		            filecontent.close();
		        }
		        if (writer != null) {
		            writer.close();
		        }
		    }
		}

		private String getFileName(final Part part) {
		    final String partHeader = part.getHeader("content-disposition");
		    for (String content : part.getHeader("content-disposition").split(";")) {
		        if (content.trim().startsWith("filename")) {
		            return content.substring(
		                    content.indexOf('=') + 1).trim().replace("\"", "");
		        }
		    }
		    return null;
		}
		
		private void generateXML(String filename){

//			File file = new File("FileToSend.txt");
//		
//			HttpPost post = new HttpPost("http://jakarata.apache.org/");
//
//			InputStream in = post.getResponseBodyAsStream();
		}
}
