/*-----------------------------
PhoneQuerier Servlet 
url-mapping : phone.get 

return the available user list 

Copyright NTHU CS15 Mao Chen-Ning 
-----------------------------*/

package cloudservice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

/**
 * Servlet implementation class PhoneQuerier
 */

public class PhoneQuerier extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	
	private static Calendar cal;
	private String day_str;
	private String time;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhoneQuerier() {
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
			
			int hour, day;
			
			cal = Calendar.getInstance();
			day = cal.get(Calendar.DAY_OF_WEEK);
			hour = cal.get(Calendar.HOUR_OF_DAY);

			switch(day){
				case Calendar.SUNDAY:
					day_str = new String("s");
					break;
				case Calendar.MONDAY:
					day_str = new String("m");
					break;
				case Calendar.TUESDAY:
					day_str = new String("t");
					break;
				case Calendar.WEDNESDAY:
					day_str = new String("w");
					break;
				case Calendar.THURSDAY:
					day_str = new String("th");
					break;
				case Calendar.FRIDAY:
					day_str = new String("f");
					break;
				case Calendar.SATURDAY:
					day_str = new String("st");
					break;
			}
			
			time=new String(day_str.concat(Integer.toString((hour/2)*2)));
			
			Statement s = (Statement) con.createStatement();
			String getPhone = "select account from chi_tai where " + time + " = '1' ";
			ResultSet result = s.executeQuery(getPhone);
			
			
			List<String> phone_array = new ArrayList<String>();
			
			while(result.next()){
				phone_array.add(result.getString("account"));
			}
			String[] resp_array = phone_array.toArray(new String[phone_array.size()]);
			Gson gson = new Gson();
			String gs = gson.toJson(resp_array);
			System.out.println("Debug:PhoneQuerier Get Schedule Array (JSON ARRAY)"+gs);
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
	}

}
