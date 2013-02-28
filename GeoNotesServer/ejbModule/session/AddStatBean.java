package session;

import java.sql.Date;

import javax.ejb.Stateless;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import entity.Route;
import entity.Stat;
import entity.User;


@Stateless(mappedName = "AddStatBean")
@WebService(serviceName="AddStatService")
@SOAPBinding(style = Style.RPC)
public class AddStatBean implements AddStatLocal{

    @Override
    @WebMethod(operationName = "addStat")
    public void addStat(@WebParam(name="username")String username, @WebParam(name="routeid")String routeid, @WebParam(name="timespent")String timespent) {
        // TODO Auto-generated method stub
        Stat userstat = new Stat();
        int idofroute = Integer.parseInt(routeid);
        long timeused = Long.parseLong(timespent);
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();
        EntityTransaction userTransaction = em.getTransaction();
        
        User user = em.find(User.class, username);
        Route route = em.find(Route.class, idofroute);
        userstat.setStatuser(user);
        userstat.setStatroute(route);
        userstat.setTimeused(timeused);
        userstat.setDate(new Date(System.currentTimeMillis()));
        
        
        userTransaction.begin();
        em.persist(userstat);
        userTransaction.commit();
        
        em.close();
        entityManagerFactory.close();
    }
    
}
