package session;

import javax.ejb.Local;


@Local
public interface FilterRouteLocal {
    public String retrieveRoute(String routename, String departure, String destination, String latitude, String longitude);
}
