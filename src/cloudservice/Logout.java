/*-----------------------------
Logout Handler Servlet 
url-mapping : member.logout
handle User Logout

Copyright NTHU CS15 Mao Chen-Ning 
-----------------------------*/

package cloudservice;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Logout
 */

public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @throws IOException 
     * @see HttpServlet#HttpServlet()
     */
	
	protected void processLogout(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String account = (String)session.getAttribute("login");
        String type = (String)session.getAttribute("type");
        System.out.println("Debug:"+type+":"+account+" Logout");
        //destroy session 
        session.invalidate();
        out.print("logout");
   
	}
	
    public Logout() {
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
		processLogout(request,response);
	}

}
