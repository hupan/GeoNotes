package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import session.RetrievePlacesLocal;

import net.sf.json.JSONArray;

/**
 * Servlet implementation class RetrieveServlet
 */
@WebServlet("/RetrieveServlet")
public class RetrieveServlet extends HttpServlet {
    @EJB
    RetrievePlacesLocal retrievePlacesBean;
    
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetrieveServlet() {
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
        JSONArray places = JSONArray.fromObject(retrievePlacesBean.retrieveAllPlaces());
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(places);
        out.flush();
        return;
	}

}
