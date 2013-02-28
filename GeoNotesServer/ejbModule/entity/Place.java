package entity;

import java.sql.Time;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Place {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int place_id;
    
    private String place_name;
    
    private double place_longitude;
    
    private double place_latitude;
    
    private double place_height;
    
    private Time place_time;
    
    private String place_description;

    public Place(){
        super();
    }

    public String getPlace_name() {
        return place_name;
    }

    public void setPlace_name(String place_name) {
        this.place_name = place_name;
    }

    public double getPlace_latitude() {
        return place_latitude;
    }

    public void setPlace_latitude(double place_latitude) {
        this.place_latitude = place_latitude;
    }

    public double getPlace_longitude() {
        return place_longitude;
    }

    public void setPlace_longitude(double place_longitude) {
        this.place_longitude = place_longitude;
    }

    public double getPlace_height() {
        return place_height;
    }

    public void setPlace_height(double place_height) {
        this.place_height = place_height;
    }

    public Time getPlace_time() {
        return place_time;
    }

    public void setPlace_time(Time place_time) {
        this.place_time = place_time;
    }

    public String getPlace_description() {
        return place_description;
    }

    public void setPlace_description(String place_description) {
        this.place_description = place_description;
    }

    public int getPlace_id() {
        return place_id;
    }

    public void setPlace_id(int place_id) {
        this.place_id = place_id;
    }
    
    
}
