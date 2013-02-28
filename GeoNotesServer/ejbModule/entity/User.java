package entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class User{
    
    @Id
    private String user_name;
    
    private String user_pwd;
    
    private int user_priority;
    
    @OneToMany(mappedBy = "statuser")
    private List<Stat> stats; 
    
    public User(){
        super();
        this.stats = new ArrayList<Stat>();
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_pwd() {
        return user_pwd;
    }

    public void setUser_pwd(String user_pwd) {
        this.user_pwd = user_pwd;
    }

    public int getUser_priority() {
        return user_priority;
    }

    public void setUser_priority(int user_priority) {
        this.user_priority = user_priority;
    }

    public List<Stat> getStats(){
        return this.stats;
    }
   
    public void setStats(List<Stat> stats){
        this.stats = stats;
    }
    
}