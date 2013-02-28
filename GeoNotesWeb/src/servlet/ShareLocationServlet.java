package servlet;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import session.ShareLocationLocal;

/**
 * Servlet implementation class ShareLocationServlet
 */
@WebServlet("/ShareLocationServlet")
public class ShareLocationServlet extends HttpServlet {
    
    @EJB
    ShareLocationLocal shareLocationBean;
    
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShareLocationServlet() {
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
	    String number = request.getParameter("number");
	    String latitude = request.getParameter("latitude");
	    String longitude = request.getParameter("longitude");
	    shareLocationBean.shareLocation(number, latitude, longitude);
	}

}
