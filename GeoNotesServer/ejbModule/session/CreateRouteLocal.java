package session;

import javax.ejb.Local;

@Local
public interface CreateRouteLocal {
    public boolean createRoute(String routename, String comment, String routedistance, String startpointid, String endpointid,String interpoints);
    public boolean updateRoute(String currouteid, String routename, String comment, String routedistance, String startpointid, String endpointid, String interpoints);
}
