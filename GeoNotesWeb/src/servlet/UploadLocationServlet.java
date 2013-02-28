package servlet;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import session.UploadLocationLocal;

/**
 * Servlet implementation class UploadLocationServlet
 */
@WebServlet("/UploadLocationServlet")
public class UploadLocationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	UploadLocationLocal uploadLocationBean;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadLocationServlet() {
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
	    String placename = request.getParameter("placename");
	    String description = request.getParameter("description");
	    String longitude = request.getParameter("longitude");
	    String latitude = request.getParameter("latitude");
	    
//	    JSONObject jsonobject = new JSONObject();
	    
	    
//	    HttpSession session = request.getSession();
//	    String lastplace = null;
//	    if(session.getAttribute("lastplace")!=null){
//	        lastplace = (String)session.getAttribute("lastplace");
//	        jsonobject = uploadLocationBean.getlocation(lastplace);
//	    }
//	    session.setAttribute("lastplace", placename);
	    
	    uploadLocationBean.upload(placename, description, latitude, longitude);
	    
//	    response.setContentType("application/json");
//	    PrintWriter out = response.getWriter();
//	    out.print(jsonobject);
//	    out.flush();
	    
	}

}
