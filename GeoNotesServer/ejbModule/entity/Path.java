package entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Path implements Comparable<Path>{
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="path_id")
    private int path_id;
    
    private int path_startpoint;
    
    private int path_endpoint;
    
    private int path_order;
    
    @ManyToOne
    private Route route;

    public Path(){
        super();
    }

    public int getPath_id() {
        return path_id;
    }

    public void setPath_id(int path_id) {
        this.path_id = path_id;
    }

    public int getPath_startpoint() {
        return path_startpoint;
    }

    public void setPath_startpoint(int path_startpoint) {
        this.path_startpoint = path_startpoint;
    }

    public int getPath_endpoint() {
        return path_endpoint;
    }

    public void setPath_endpoint(int path_endpoint) {
        this.path_endpoint = path_endpoint;
    }

    
    public Route getRoute() {
        return route;
    }

    
    public void setRoute(Route route) {
        this.route = route;
    }

    public int getPath_order() {
        return path_order;
    }

    public void setPath_order(int path_order) {
        this.path_order = path_order;
    }

    @Override
    public int compareTo(Path o) {
        int pathorder = o.getPath_order();
        return this.path_order-pathorder;
    }


}
