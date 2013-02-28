package session;

import java.util.ArrayList;
import java.util.Collections;
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
import javax.persistence.Persistence;
import javax.persistence.Query;

import entity.Path;
import entity.Place;
import entity.Route;

import net.sf.json.JSONArray;

@Stateless(mappedName="FilterRouteBean")
@WebService(serviceName = "FilterRouteService")
@SOAPBinding(style = Style.RPC)
public class FilterRouteBean implements FilterRouteLocal{
    
    //Calculate distance between two points
    //Used to calculate distances between route departure points and user's current location
    //Notice that the distance values stored for each route is calculated using GOOGLE MAPS API, not this one
    private int calculateDistance(double lat1, double lng1, double lat2, double lng2){
        double earthRadius = 3958.75;
        double dLat = Math.toRadians(lat2-lat1);
        double dLng = Math.toRadians(lng2-lng1);
        double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                Math.sin(dLng/2) * Math.sin(dLng/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        double dist = earthRadius * c;
        int meterConversion = 1609;
        return (int) (dist * meterConversion);
    }

    @SuppressWarnings("unchecked")
    @Override
    @WebMethod(operationName = "retrieveRoute")
    @WebResult(name = "route")
    public String retrieveRoute(@WebParam(name="routename")String routename, @WebParam(name="departure")String departure,
            @WebParam(name="destination")String destination, @WebParam(name="latitude")String latitude, 
            @WebParam(name="longitude")String longitude) {
        double userLatitude = Double.parseDouble(latitude);
        double userLongitude = Double.parseDouble(longitude);
        JSONArray route = new JSONArray();
        Query query;
        String queryString = new String("");
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();
        List<Route> routes = new ArrayList<Route>();
        List<Object> results = new ArrayList<Object>();
        List<Path> paths = new ArrayList<Path>();
        List<Integer> placeids = new ArrayList<Integer>();
        Place tempPlace = new Place();
        Route minRoute = new Route();
        
        if(routename.equals("")){
            queryString = "SELECT r FROM Route r LEFT JOIN FETCH r.paths, IN(r.paths) pa, Place pl WHERE pa.path_endpoint=pl.place_id AND pl.place_name=:destination";
            if(departure.equals("")){
                query = em.createQuery(queryString);
                query.setParameter("destination", destination);
            }
            else{
                queryString = "SELECT r FROM Route r LEFT JOIN FETCH r.paths, IN(r.paths) pa, IN(r.paths) pb, Place pl, Place pm WHERE pa.path_startpoint=pl.place_id AND pl.place_name=:departure AND pb.path_endpoint=pm.place_id AND pm.place_name=:destination";
                query = em.createQuery(queryString);
                query.setParameter("departure", departure);
                query.setParameter("destination", destination);
            }
        }
        else{
            queryString = "SELECT r FROM Route r LEFT JOIN FETCH r.paths, IN(r.paths) pa, Place pl WHERE r.route_name=:routename AND pa.path_endpoint=pl.place_id AND pl.place_name=:destination";
            if(departure.equals("")){
                query = em.createQuery(queryString);
                query.setParameter("routename", routename);
                query.setParameter("destination", destination);
            }
            else{
                queryString = "SELECT r FROM Route r LEFT JOIN FETCH r.paths, IN(r.paths) pa, IN(r.paths) pb, Place pl, Place pm WHERE r.route_name=:routename AND pa.path_startpoint=pl.place_id AND pl.place_name=:departure AND pb.path_endpoint=pm.place_id AND pm.place_name=:destination";
                query = em.createQuery(queryString);
                query.setParameter("routename", routename);
                query.setParameter("departure", departure);
                query.setParameter("destination", destination);
            }
        }
        routes = query.getResultList();
        if(routes != null && routes.size() > 0){
            int minId = 0;
            int minDistance = 0;
            int tempDistance = 0;
            
            for(int j=0; j<routes.size(); j++){
                paths = routes.get(j).getPaths();

                int tempId = 0;
                if(!paths.isEmpty()){
                    tempId = paths.get(0).getPath_startpoint();
                }
                tempPlace = em.find(Place.class, tempId);
                tempDistance = calculateDistance(tempPlace.getPlace_latitude(), tempPlace.getPlace_longitude(), userLatitude, userLongitude);
                if(j==0){
                    minDistance = tempDistance;
                }
                else if(tempDistance<minDistance){
                    minDistance = tempDistance;
                    minId = j;
                }
            }
            minRoute = routes.get(minId);
            paths = minRoute.getPaths();
            Collections.sort(paths);
            
            placeids = new ArrayList<Integer>();
            int i = 0;
            for(i=0; i<paths.size()-1; i++){
                placeids.add(paths.get(i).getPath_startpoint());
            }
            placeids.add(paths.get(i).getPath_startpoint());
            placeids.add(paths.get(i).getPath_endpoint());
            for(int k=0;k<placeids.size();k++){
                queryString = "SELECT pl.place_name, pl.place_description, pl.place_latitude, pl.place_longitude FROM Place pl WHERE pl.place_id = :pid";
                query = em.createQuery(queryString);
                query.setParameter("pid", placeids.get(k));
                results.add(query.getResultList().get(0));
            }
            
        }
        em.close();
        entityManagerFactory.close();
        
        if(results.isEmpty()){
            return null;
        }
        
        route = JSONArray.fromObject(results);
        JSONArray curArray;
        for(int k=0; k<route.size(); k++){
            curArray = route.getJSONArray(k);
            curArray.add(minRoute.getRoute_name());
            curArray.add(minRoute.getRoute_comment());
            curArray.add(minRoute.getRoute_distance());
            curArray.add(minRoute.getRoute_id());
        }
        
        return route.toString();
    }
    
}
