package session;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;

import entity.Path;
import entity.Route;

import net.sf.json.JSONArray;

@Stateless(mappedName = "CreateRouteBean")
@WebService(serviceName = "CreateRouteService")
@SOAPBinding(style = Style.RPC)
public class CreateRouteBean implements CreateRouteLocal{

    @Override
    @WebMethod(operationName = "createRoute")
    @WebResult(name = "ifcreated")
    public boolean createRoute(@WebParam(name="routename")String routename, @WebParam(name="comment")String comment, 
    		@WebParam(name="routedistance")String routedistance, @WebParam(name="startpointid")String startpointid, 
    		@WebParam(name="endpointid")String endpointid, @WebParam(name="interpoints")String interpoints) {
        JSONArray pointsArray = JSONArray.fromObject(interpoints);
        List<Path> paths = new ArrayList<Path>();
        Route route = new Route();
        route.setRoute_name(routename);
        route.setRoute_comment(comment);
        route.setRoute_distance(Integer.parseInt(routedistance));
        
        if(pointsArray == null || pointsArray.size() == 0){
            Path path = new Path();
            path.setPath_startpoint(Integer.parseInt(startpointid));
            path.setPath_endpoint(Integer.parseInt(endpointid));
            path.setPath_order(0);
            path.setRoute(route);
            paths.add(path);
//            route.getPaths().add(path);
        }
        else{
            Path path = new Path();
            path.setPath_startpoint(Integer.parseInt(startpointid));
            path.setPath_endpoint(pointsArray.getInt(0));
            path.setPath_order(0);
            path.setRoute(route);
            paths.add(path);
//            route.getPaths().add(path);
            int i = 0;
            for(i=0; i<pointsArray.size()-1; i++){
                path = new Path();
                path.setPath_startpoint(pointsArray.getInt(i));
                path.setPath_endpoint(pointsArray.getInt(i+1));
                path.setPath_order(i+1);
                path.setRoute(route);
                paths.add(path);
//                route.getPaths().add(path);
            }
            path = new Path();
            path.setPath_startpoint(pointsArray.getInt(i));
            path.setPath_endpoint(Integer.parseInt(endpointid));
            path.setPath_order(i+1);
            path.setRoute(route);
            paths.add(path);
//            route.getPaths().add(path);
        }
        
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();
        EntityTransaction userTransaction = em.getTransaction();
        
        userTransaction.begin();
        em.persist(route);
        for(int j=0; j<paths.size(); j++){
            em.persist(paths.get(j));
        }
        
        userTransaction.commit();
        em.close();
        entityManagerFactory.close();        
        
        return true;
    }

    @Override
    @WebMethod(operationName = "updateRoute")
    @WebResult(name = "ifupdated")
    public boolean updateRoute(@WebParam(name="currouteid")String currouteid, @WebParam(name="routename")String routename,
            @WebParam(name="comment")String comment, @WebParam(name="routedistance")String routedistance, 
            @WebParam(name="startpointid")String startpointid, @WebParam(name="endpointid")String endpointid, 
            @WebParam(name="interpoints")String interpoints) {
        JSONArray pointsArray = JSONArray.fromObject(interpoints);
        List<Path> paths = new ArrayList<Path>();
        
        if(pointsArray == null || pointsArray.size() == 0){
            Path path = new Path();
            path.setPath_startpoint(Integer.parseInt(startpointid));
            path.setPath_endpoint(Integer.parseInt(endpointid));
            path.setPath_order(0);
            paths.add(path);
//            route.getPaths().add(path);
        }
        else{
            Path path = new Path();
            path.setPath_startpoint(Integer.parseInt(startpointid));
            path.setPath_endpoint(pointsArray.getInt(0));
            path.setPath_order(0);
            paths.add(path);
//            route.getPaths().add(path);
            int i = 0;
            for(i=0; i<pointsArray.size()-1; i++){
                path = new Path();
                path.setPath_startpoint(pointsArray.getInt(i));
                path.setPath_endpoint(pointsArray.getInt(i+1));
                path.setPath_order(i+1);
                paths.add(path);
//                route.getPaths().add(path);
            }
            path = new Path();
            path.setPath_startpoint(pointsArray.getInt(i));
            path.setPath_endpoint(Integer.parseInt(endpointid));
            path.setPath_order(i+1);
            paths.add(path);
//            route.getPaths().add(path);
        }
        
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();
        EntityTransaction userTransaction = em.getTransaction();
        
        userTransaction.begin();
        Query query = em.createQuery("SELECT r FROM Route as r INNER JOIN FETCH r.paths WHERE r.route_id=:routeid");
        query.setParameter("routeid", Integer.parseInt(currouteid));

        @SuppressWarnings("unchecked")
        List<Route> routes = query.getResultList();
        Route route = routes.get(0);
        route.setRoute_name(routename);
        route.setRoute_comment(comment);
        route.setRoute_distance(Integer.parseInt(routedistance));
        List<Path> pathsofroute = route.getPaths();
        for(int i=0; i<pathsofroute.size(); i++){
            em.remove(pathsofroute.get(i));
        }
        pathsofroute.clear();
        pathsofroute = paths;
        
        
        for(int j=0; j<pathsofroute.size(); j++){
            pathsofroute.get(j).setRoute(route);
            em.persist(pathsofroute.get(j));
        }
        em.persist(route);
        userTransaction.commit();
        em.close();
        entityManagerFactory.close();        
        
        return true;
    }
    
}
