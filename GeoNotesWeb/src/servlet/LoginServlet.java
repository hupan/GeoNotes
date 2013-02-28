package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import session.LoginLocal;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	LoginLocal loginBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
	       String username = request.getParameter("username");
	       String passwd = request.getParameter("passwd");
	       int prio = loginBean.login(username, passwd);
	       if(prio == -1){
	            response.setContentType("text/html"); 
	            PrintWriter out= response.getWriter(); 
	            out.write("error");
	       }
	       else if(prio == 1){
	           ServletContext application = this.getServletContext();
	           RequestDispatcher rd = application.getRequestDispatcher("/adminboard.jsp");
	           rd.forward(request, response);
	       }
	       else if(prio == 0){
               ServletContext application = this.getServletContext();
               RequestDispatcher rd = application.getRequestDispatcher("/userboard.jsp");
               request.setAttribute("username", username);
               rd.forward(request, response);
	       }
	}

}
