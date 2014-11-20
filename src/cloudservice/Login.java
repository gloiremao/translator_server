/*-----------------------------
Login Handler Servlet 
url-mapping : member.login 
handle User Login

Copyright NTHU CS15 Mao Chen-Ning 
-----------------------------*/

package cloudservice;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class Login
 * 
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//private String error_msg;
    
	private String username;
	private String mail;
	private String lang; 
	protected boolean checkLogin(String type,String account,String pwd){
		boolean login_state = false;
		try {
			//handle jdbc driver 
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cloud?characterEncoding=UTF-8", "user", "user");
			if(!con.isClosed())System.out.println("LoginHandler:Connect to DB"); 
			
			Statement s = (Statement) con.createStatement();
			//prepare my sql script to avoid sql injection 
			String sql = "SELECT * FROM "+type+"_user WHERE account= ?";
			String isUserExisted = "SELECT COUNT(1) FROM "+type+"_user WHERE account= ?";
			
			//jump sql statement 
			PreparedStatement checkLoginSQL = con.prepareStatement(sql);
			PreparedStatement checkUserSQL = con.prepareStatement(isUserExisted);
			checkLoginSQL.setString(1, account);
			checkUserSQL.setString(1, account);
			
			ResultSet r = checkUserSQL.executeQuery();
			//check account existed or not 
			if(r.next() && r.getInt(1) == 1){
				ResultSet result = checkLoginSQL.executeQuery();
				result.next();
				//check password
				if(!result.getString("pwd").equals(pwd)){
					System.out.println("Wrong password");
					//error_msg = "Wrong password";
				}else{
					//if login successfully
					username = result.getString("name");
					mail = result.getString("mail");
					//prepare language for build translator's schedule table which implement in scheduleHandler 
					if(type.equals("translator"))lang = result.getString("lang");
					
					System.out.print("LoginHandler:Account: "+result.getString("account"));
					System.out.print(" User: "+username);
					//set login signal 
					login_state = true;
				}
			}else{
				System.out.println("User isn't existed");
				//error_msg = "account isn't existed";
			}
			
			s.close();
	        con.close();
	        
		}
		catch(ClassNotFoundException e){
			throw new RuntimeException("LoginHandler:Cannot find jdbc class");
		}
		catch(SQLException e) { 
            e.printStackTrace(); 
        }
		
		return login_state;
	}
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Debug: Ajax test GET");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String type = "normal"; 
		type = request.getParameter("type");				
		String account = request.getParameter("account");
		String pwd = request.getParameter("pwd");
		System.out.println("LoginHandler:"+type+" user try to Login Account:"+account);
		
		response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        
        PrintWriter out = response.getWriter();
        //System.out.println("LoginHandler: Session:"+session.getAttribute("login"));
		if(checkLogin(type,account,pwd)){
			System.out.println("LoginHandler: login in!!!");
			//prepare http session 
			session.setAttribute("login", account);
			session.setAttribute("user",username);
			session.setAttribute("mail",mail);
			session.setAttribute("type", type);
			if( type.equals("translator") ){
				//set language session (not complete 
				if(lang.equals("tai"))session.setAttribute("lang","®õ¤å");
			}
			out.print("login");
		}else{
			System.out.println("LoginHandler:login fail!!!");
			out.print("fail");
		}
		out.close();
	}

}
