package entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Route {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="route_id")
    private int route_id;
    
    private String route_name;
    
    private String route_comment;
    
    private int route_distance;
    
    @OneToMany(mappedBy="route")
    private List<Path> paths;
    
    public Route(){
        super();
        this.paths = new ArrayList<Path>();
    }

    public int getRoute_distance(){
        return this.route_distance;
    }
    
    public void setRoute_distance(int route_distance){
        this.route_distance = route_distance;
    }
    
    public int getRoute_id() {
        return route_id;
    }

    public void setRoute_id(int route_id) {
        this.route_id = route_id;
    }

    public String getRoute_name() {
        return route_name;
    }

    public void setRoute_name(String route_name) {
        this.route_name = route_name;
    }

    public String getRoute_comment() {
        return route_comment;
    }

    public void setRoute_comment(String route_comment) {
        this.route_comment = route_comment;
    }

    public List<Path> getPaths() {
        return paths;
    }

    public void setPaths(List<Path> paths) {
        this.paths = paths;
    }
}
