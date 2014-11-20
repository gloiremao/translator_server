/*-----------------------------
Schedule Handler Servlet 
url-mapping : schedule.update


Copyright NTHU CS15 Mao Chen-Ning 
-----------------------------*/

package cloudservice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class ScheduleHandler
 */
public class ScheduleHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    /**
     * @see HttpServlet#HttpServlet()
     */
	private void changeScheduleHandler(String account,String[] add,String[] remove){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cloud?characterEncoding=UTF-8", "user", "user");
			if(!con.isClosed())System.out.println("SchedueHandler:Connect to DB"); 
			
			Statement s = (Statement) con.createStatement();
			
			//set table and prepare sql 
			String updateSchedule = "UPDATE chi_tai SET ";
			if(remove == null){
				//handle remove data null
				updateSchedule += add[0]+"='1' ";
				for(int i = 1;i < add.length; i++){
					updateSchedule += ","+add[i]+"='1'";
				}
			}else if(add == null){
				//handle add data null
				updateSchedule += remove[0]+"='0' ";
				for(int i = 1;i < remove.length; i++){
					updateSchedule += ","+remove[i]+"='0'";
				}
			}else {
				//handle time_data
				updateSchedule += add[0]+"='1' ";
				for(int i = 1;i < add.length; i++){
					updateSchedule += ","+add[i]+"='1'";
				}
				for(int i = 0;i < remove.length; i++){
					updateSchedule += ","+remove[i]+"='0'";
				}
				
			}
			
			updateSchedule += "WHERE account='"+account+"';";
			System.out.println("SQL:"+updateSchedule);
			s.executeUpdate(updateSchedule);
	        s.close();
	        con.close();
		}
		catch(ClassNotFoundException e){
			throw new RuntimeException("Cannot find jdbc class");
		}
		catch(SQLException e) { 
            e.printStackTrace();
        }
	}
	
	
    public ScheduleHandler() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cloud?characterEncoding=UTF-8", "user", "user");
			if(!con.isClosed())System.out.println("SchedueHandler:Connect to DB"); 
			
			Statement s = (Statement) con.createStatement();
			HttpSession session = request.getSession();
			String account = (String) session.getAttribute("login");
			//String lang = (String) session.getAttribute("lang");
			String getSchedule = "SELECT * FROM chi_tai WHERE account='"+account+"';";
			ResultSet result = s.executeQuery(getSchedule);
			ResultSetMetaData metadata = result.getMetaData(); 
			int col = metadata.getColumnCount();
			
			List<String> time_array = new ArrayList<String>();
			
			while(result.next()){
				for(int i = 2;i <= col; i++){
					if(result.getInt(i) == 1){
						time_array.add(metadata.getColumnName(i));
					}
					//System.out.println("Time:"+metadata.getColumnName(i)+"a:"+result.getInt(i));
				}
			}
			
			String[] resp_array = time_array.toArray(new String[time_array.size()]);
			//System.out.println("debug: array "+resp_array);
			Gson gson = new Gson();
			String gs = gson.toJson(resp_array);
			System.out.println("Debug:ScheduleHandler Get Schedule Array (JSON ARRAY)"+gs);
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(gs);
			
	        s.close();
	        con.close();
		}
		catch(ClassNotFoundException e){
			throw new RuntimeException("Cannot find jdbc class");
		}
		catch(SQLException e) { 
            e.printStackTrace(); 
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String[] Add_Item = request.getParameterValues("addItem[]");
		String[] Delete_Item = request.getParameterValues("deleteItem[]");
		
		//get user from session 
		HttpSession session = request.getSession();
		String account = (String) session.getAttribute("login");
		if(Add_Item != null){
			for (int i = 0; i < Add_Item.length; i++) {
				   System.out.print(Add_Item[i] + ", ");
				}
		}
		if(Delete_Item != null){
			for (int i = 0; i < Delete_Item.length; i++) {
				   System.out.print(Delete_Item[i] + ", ");
				}
		}
		
		if(!(Add_Item == null && Delete_Item == null))changeScheduleHandler(account,Add_Item,Delete_Item);
		
		System.out.println("SchedueHandler:Update Schedule Table");
		
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write("updated");
	}

}
