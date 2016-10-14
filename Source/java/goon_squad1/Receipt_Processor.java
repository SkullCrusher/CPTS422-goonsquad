package goon_squad1;

import java.io.IOException;

import org.apache.commons.fileupload.FileItem;
import org.apache.tomcat.util.codec.binary.Base64;
import org.omg.CORBA.NameValuePair;

import sun.net.www.http.HttpClient;

import com.abbyy.ocrsdk.*;

import java.util.ArrayList;
import java.util.List;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLConnection;
import java.io.*;
import java.net.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class Receipt_Processor extends HttpServlet {
	private static Client restClient;
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		  response.setContentType("text/html;charset=UTF-8");
		    // Create path components to save the file
		    //final String path = "C:/Users/Jordan/workspace_ee/goon_squad1/uploads";//request.getParameter("destination");
		    final String path = "C:/goon_squad/eclipse_workspace/uploads";//request.getParameter("destination");
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
		    String outputPath = "C:/goon_squad/eclipse_workspace/data/"+fileName+".xml";
		   // String outputPath = "C:/Users/Jordan/workspace_ee/goon_squad1/data/"+fileName+".xml";
		    try {
				generateXML(path + "/" + fileName, outputPath);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    try {
				parseResultXml(outputPath);
			} catch (ParserConfigurationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SAXException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    response.getWriter().println("{\"string\":\"Successful\"}");
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
		

		private void generateXML(String filepath, String outputPath) throws Exception{
			restClient = new Client();
			// replace with 'https://cloud.ocrsdk.com' to enable secure connection
			restClient.serverUrl = "http://cloud.ocrsdk.com";
			restClient.applicationId = "RMS an online receipt management system";
			restClient.password = "PiGpNzblC5XaXh50r/LSH8yQ";
			com.abbyy.ocrsdk.Task task = null;
			String url = "https://cloud.ocrsdk.com/processImage?exportFormat=xml";
			URL myurl = new URL(url);
			HttpURLConnection con = (HttpURLConnection)myurl.openConnection();
/*			ProcessingSettings.OutputFormat outputFormat = ProcessingSettings.OutputFormat.xml;
			ProcessingSettings settings = new ProcessingSettings();
			settings.setOutputFormat(outputFormat);
			settings.setLanguage("English");*/
			task = restClient.processReceipt(filepath);//, settings);
			waitAndDownloadResult(task, outputPath);
		}
		
		private static void waitAndDownloadResult(Task task, String outputPath)
				throws Exception {
			task = waitForCompletion(task);

			if (task.Status == Task.TaskStatus.Completed) {
				System.out.println("Downloading..");
				restClient.downloadResult(task, outputPath);
				System.out.println("Ready");
			} else if (task.Status == Task.TaskStatus.NotEnoughCredits) {
				System.out.println("Not enough credits to process document. "
						+ "Please add more pages to your application's account.");
			} else {
				System.out.println("Task failed");
			}
		}
		private static Task waitForCompletion(Task task) throws Exception {
			// Note: it's recommended that your application waits
			// at least 2 seconds before making the first getTaskStatus request
			// and also between such requests for the same task.
			// Making requests more often will not improve your application performance.
			// Note: if your application queues several files and waits for them
			// it's recommended that you use listFinishedTasks instead (which is described
			// at http://ocrsdk.com/documentation/apireference/listFinishedTasks/).
			while (task.isTaskActive()) {

				Thread.sleep(5000);
				System.out.println("Waiting..");
				task = restClient.getTaskStatus(task.Id);
			}
			return task;
		}
		
		private void parseResultXml(String outputPath) throws ParserConfigurationException, SAXException, IOException{
			File dataFile = new File(outputPath);
			DocumentBuilderFactory factory =
					DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(dataFile);
			Receipt rec = new Receipt();
			Item item = new Item();
			rec.store = doc.getElementsByTagName("classifiedValue").item(0).getTextContent();
			System.out.println(rec.store);
			Node n = doc.getElementsByTagName("total").item(0);
			rec.total_cost = n.getFirstChild().getTextContent();
			System.out.println(rec.total_cost);
			NodeList nlist = doc.getElementsByTagName("item"), itm;
			rec.itemslist = new ArrayList<Item>();
			Element el;
			for (int i =0; i<nlist.getLength(); i++) {
				n = nlist.item(i);
				itm = n.getChildNodes();//n.getFirstChild();
				el = (Element) itm.item(0);
				System.out.println("name "+el.getTextContent());
				System.out.println("value "+itm.item(0).getNodeValue());
				System.out.println("text "+itm.item(0).getTextContent());
		//		item.name = itm.item(0).get.getTextContent();///.getFirstChild().getTextContent();
		//	System.out.println(item.name);
				//System.out.println(n.getNodeName());
				item.value = itm.item(2).getTextContent();
				System.out.println(item.value);
				rec.itemslist.add(item);
			} 
		}
		
}
