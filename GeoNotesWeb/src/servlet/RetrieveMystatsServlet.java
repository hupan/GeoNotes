package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import session.RetrieveStatsLocal;

import net.sf.json.JSONArray;

/**
 * Servlet implementation class RetrieveMystatsServlet
 */
@WebServlet("/RetrieveMystatsServlet")
public class RetrieveMystatsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	RetrieveStatsLocal retrieveStatsBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetrieveMystatsServlet() {
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
	    String username = request.getParameter("username");
        JSONArray stats = JSONArray.fromObject(retrieveStatsBean.getStatsByUsername(username));
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(stats);
        out.flush();
        return;
	}

}
