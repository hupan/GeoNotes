package entity;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Stat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne
    private User statuser;
    
    @ManyToOne
    private Route statroute;
    
    private Date date;
    
    private long timeused;
    
    public Stat(){
        super();
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public long getTimeused() {
        return timeused;
    }

    public void setTimeused(long timeused) {
        this.timeused = timeused;
    }
    
    public User getStatuser(){
        return this.statuser;
    }
    
    public void setStatuser(User statuser){
        this.statuser = statuser;;
    }
    
    public Route getStatroute(){
        return this.statroute;
    }
    
    public void setStatroute(Route statroute){
        this.statroute = statroute;
    }
    
    public int getId(){
        return this.id;
    }
    
    public void setId(int id){
        this.id = id;
    }
    
    
}
