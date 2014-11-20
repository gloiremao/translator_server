/*-----------------------------
Login Handler Servlet 
url-mapping : member.login 
handle User Login

Copyright NTHU CS15 Mao Chen-Ning 
-----------------------------*/

package cloudservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.sql.SQLException;

/**
 * Servlet implementation class Membership
 */
@WebServlet("/member")
public class Membership extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void processRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cloud?characterEncoding=UTF-8", "user", "user");
			if(!con.isClosed())System.out.println("ProcessRegister: Connect to DB"); 
			
			Statement s = (Statement) con.createStatement();
			
			//analyze request 
			String type = request.getParameter("type");
			String account = request.getParameter("account");
			String pwd = request.getParameter("pwd");
			String mail = request.getParameter("mail");
			String name = request.getParameter("name");
			
			
			if(type.equals("normal")){
				String sql = "INSERT INTO normal_user(account, pwd, mail, name) VALUES ('"+account+"', '"+pwd+"', '"+mail+"', '"+name+"')";
				//sql for auto-added asterisk member for normal user to use quick login on app
				String aster_sql = "INSERT INTO app_user(name,secret,defaultuser) VALUES ('"+account+"', '"+pwd+"', '"+account+"')";
				s.executeUpdate(sql);
				s.executeUpdate(aster_sql);
				System.out.println("ProcessRegister: Insert data "+type+"_user "+account+" "+pwd+" "+mail+" "+name);
			}else if(type.equals("translator")){
				String lang = request.getParameter("lang");
				String sql = "INSERT INTO translator_user(account, pwd, mail, name, lang) VALUES ('"+account+"', '"+pwd+"', '"+mail+"', '"+name+"', '"+lang+"')";
				String time = "INSERT INTO chi_"+lang+"(account) VALUES('"+account+"')";
				s.executeUpdate(sql);
				s.executeUpdate(time);
				System.out.println("ProcessRegister:: Insert data "+type+"_user "+account+" "+pwd+" "+mail+" "+name);
			}
			
			
			
			
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
     * @see HttpServlet#HttpServlet()
     */
    public Membership() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		try {
			processRegister(request,response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
