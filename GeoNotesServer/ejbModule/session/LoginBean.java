package session;

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

import entity.User;

@Stateless(mappedName = "LoginBean")
@WebService(serviceName="LoginService")
@SOAPBinding(style = Style.RPC)
public class LoginBean implements LoginLocal{

    @Override
    @WebMethod(operationName="login")
    @WebResult(name="ifsuccess")
    public int login(@WebParam(name="username")String username, @WebParam(name="passwd")String passwd) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();

        Query query = em.createQuery("SELECT u FROM User as u where u.user_name = :username and u.user_pwd = :userpwd");
        query.setParameter("username", username);
        query.setParameter("userpwd", passwd);
        @SuppressWarnings("unchecked")
        List<User> users = query.getResultList();
        em.close();
        entityManagerFactory.close();
        if(users.size()>0){
            return users.get(0).getUser_priority();
        }
        return -1;
    }

    @Override
    @WebMethod(operationName="register")
    @WebResult(name="ifregister")
    public boolean register(@WebParam(name="username")String username, @WebParam(name="passwd")String passwd) {
    	
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("jpaunit");
        EntityManager em = entityManagerFactory.createEntityManager();
        EntityTransaction userTransaction = em.getTransaction();
        Query query = em.createQuery("SELECT u FROM User as u where u.user_name = :username");
        query.setParameter("username", username);
        @SuppressWarnings("unchecked")
        List<User> users = query.getResultList();
        
        if(users.size()>0){
            em.close();
            entityManagerFactory.close();
            return false;
        }
        
        User newUser = new User();
        newUser.setUser_name(username);
        newUser.setUser_pwd(passwd);
        userTransaction.begin();
        em.persist(newUser);
        userTransaction.commit();
        em.close();
        entityManagerFactory.close();
        return true;
    }
    
    
}
