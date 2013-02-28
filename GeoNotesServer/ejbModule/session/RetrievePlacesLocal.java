package session;

import javax.ejb.Local;

@Local
public interface RetrievePlacesLocal {
    public String retrieveAllPlaces();
}
