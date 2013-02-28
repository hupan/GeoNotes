package servlet;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import session.CreateRouteLocal;

/**
 * Servlet implementation class SaveRouteServlet
 */
@WebServlet("/SaveRouteServlet")
public class SaveRouteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	CreateRouteLocal createRouteBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveRouteServlet() {
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
	    String currouteid = request.getParameter("currouteid");
        String s = request.getParameter("waypointsids");
        String startpointid = request.getParameter("startpointid");
        String endpointid = request.getParameter("endpointid");
        String routedistance = request.getParameter("routedistance");
        String routename = request.getParameter("routename");
        String comment = request.getParameter("comment");
        createRouteBean.updateRoute(currouteid, routename, comment, routedistance, startpointid, endpointid, s);
        
        return;
	}

}
