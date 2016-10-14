package goon_squad1;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Receipt_Downloader extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
//		ByteArrayOutputStream baos = new ByteArrayOutputStream();
//		response.setContentType("application/pdf");
//        response.setHeader("Content-Disposition", "attachment; "+req.getParameter("filename"));
//        OutputStream os = response.getOutputStream();
//        baos.writeTo(os);
//        os.flush();
//        os.close();
		String fileName = request.getParameter("filename");
		if(fileName == null || fileName.equals("")){
			throw new ServletException("File Name can't be null or empty");
		}
		File file = new File("C:/Users/Jordan/workspace_ee/goon_squad1/uploads"+File.separator+fileName);
		if(!file.exists()){
			throw new ServletException("File doesn't exists on server.");
		}
		InputStream fis = new FileInputStream(file);
		response.setContentType("application/force-download");
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		
		ServletOutputStream os       = response.getOutputStream();
		byte[] bufferData = new byte[1024];
		int read=0;
		while((read = fis.read(bufferData))!= -1){
			os.write(bufferData, 0, read);
		}
		os.flush();
		os.close();
		fis.close();
		System.out.println("File downloaded at client successfully");
	}
}
