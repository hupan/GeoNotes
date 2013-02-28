package session;

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

import entity.Place;

@Stateless(mappedName = "UploadLocationBean")
@WebService(serviceName = "UploadLocationService")
@SOAPBinding(style = Style.RPC)
public class UploadLocationBean implements UploadLocationLocal{

    @Override
    @WebMethod(operationName = "upload")
    @WebResult(name = "ifuploaded")
    public boolean upload(@WebParam(name="placename")String placename, @WebParam(name="description")String description, 
    		@WebParam(name="latitude")String latitude, @WebParam(name="longitude")String longitude) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();
        EntityTransaction userTransaction = em.getTransaction();
        Place newPlace = new Place();
        newPlace.setPlace_name(placename);
        newPlace.setPlace_description(description);
        newPlace.setPlace_latitude(Double.parseDouble(latitude));
        newPlace.setPlace_longitude(Double.parseDouble(longitude));
        newPlace.setPlace_height(0.0);
        userTransaction.begin();
        em.persist(newPlace);
        userTransaction.commit();
        em.close();
        entityManagerFactory.close();
        return false;
    }
    
}
