package session;

import java.sql.Date;
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

import entity.Stat;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsDateJsonValueProcessor;

@Stateless(mappedName = "RetrieveStatsBean")
@WebService(serviceName="RetrieveStatsService")
@SOAPBinding(style = Style.RPC)
public class RetrieveStatsBean implements RetrieveStatsLocal{

    @Override
    @WebMethod(operationName="getAllStats")
    @WebResult(name="allStats")
    public String getAllStats() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();

        Query query = em.createQuery("SELECT s.date, u.user_name, r.route_name, r.route_distance, s.timeused FROM Stat s INNER JOIN s.statuser u INNER JOIN s.statroute r");

        @SuppressWarnings("unchecked")
        List<Stat> stats = query.getResultList();
        em.close();
        entityManagerFactory.close();
        JsonConfig config = new JsonConfig();  
        config.registerJsonValueProcessor(Date.class, new JsDateJsonValueProcessor());  
        return JSONArray.fromObject(stats,config).toString();

    }

    @Override
    @WebMethod(operationName = "getStatsByUsername")
    @WebResult(name = "statsByUser")
    public String getStatsByUsername(@WebParam(name="username")String username) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();

        Query query = em.createQuery("SELECT s.date, r.route_name, r.route_distance, s.timeused FROM Stat s INNER JOIN s.statuser u INNER JOIN s.statroute r WHERE u.user_name=:username");
        query.setParameter("username", username);

        @SuppressWarnings("unchecked")
        List<Stat> stats = query.getResultList();
        em.close();
        entityManagerFactory.close();
        JsonConfig config = new JsonConfig();  
        config.registerJsonValueProcessor(Date.class, new JsDateJsonValueProcessor());  
        return JSONArray.fromObject(stats,config).toString();
    }
    
}
