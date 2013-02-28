package session;

import java.util.List;


import javax.ejb.Stateless;
import javax.jws.WebMethod;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import entity.User;

import net.sf.json.JSONArray;

@Stateless(mappedName = "RetrievePlacesBean")
@WebService(serviceName="RetrievePlacesService")
@SOAPBinding(style = Style.RPC)
public class RetrievePlacesBean implements RetrievePlacesLocal{

    @Override
    @WebMethod(operationName="retrieveAllPlaces")
    @WebResult(name="allPlaces")
    public String retrieveAllPlaces() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();

        Query query = em.createQuery("SELECT p.place_name, p.place_latitude, p.place_longitude, p.place_id, p.place_name, p.place_description FROM Place p");
        @SuppressWarnings("unchecked")
        List<User> users = query.getResultList();
        em.close();
        entityManagerFactory.close();
        JSONArray places = JSONArray.fromObject(users);
        return places.toString();
    }
    
}
