package ir.samane.homeservicesoft.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class SubService {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    @OneToOne(cascade = CascadeType.ALL)
    private SubCategory type;
    private double price;
    private String description;
    @JsonIgnore
    @ManyToMany(cascade = CascadeType.ALL)
    private List<Expert> experts = new ArrayList<>();
    @ManyToOne
    private Service service;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public SubCategory getType() {
        return type;
    }

    public void setType(SubCategory type) {
        this.type = type;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Expert> getExperts() {
        return experts;
    }

    public void setExperts(List<Expert> experts) {
        this.experts = experts;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        setService(service, true);
    }

    void setService(Service service, boolean add) {
        this.service = service;
        if (service != null && add) {
            service.addSubService(this, false);
        }
    }

}
