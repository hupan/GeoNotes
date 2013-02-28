package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import session.FilterRouteLocal;

/**
 * Servlet implementation class FindServlet
 */
@WebServlet("/FindServlet")
public class FindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	FilterRouteLocal filterRouteBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindServlet() {
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
	    String departure = request.getParameter("departure");
	    String destination = request.getParameter("destination");
	    String routename = request.getParameter("routename");
	    String userLatitude = request.getParameter("mylatitude");
	    String userlongitude = request.getParameter("mylongitude");
	    if(departure.equals("Departure(optional)")){
	        departure="";
	    }
	    if(routename.equals("Route name(optional)")){
	        routename="";
	    }
	    
	    JSONArray route = JSONArray.fromObject(filterRouteBean.retrieveRoute(routename, departure, destination, userLatitude, userlongitude));
	    
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(route);
        out.flush();
        return;
	    
	}

}
