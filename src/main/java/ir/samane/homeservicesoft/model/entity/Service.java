package ir.samane.homeservicesoft.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
public class Service {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    @OneToOne(cascade = CascadeType.ALL)
    private Category type;
    @JsonIgnore
    @OneToMany(mappedBy = "service", fetch = FetchType.EAGER)
    private List<SubService> subServices = new ArrayList<>();

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

    public Category getType() {
        return type;
    }

    public void setType(Category type) {
        this.type = type;
    }

    public List<SubService> getSubServices() {
        return subServices;
    }

    public void setSubServices(List<SubService> subServices) {
        this.subServices = subServices;
    }

    void addSubService(SubService subService, boolean set) {
        if (subService != null) {
            if(getSubServices().contains(subService)) {
                getSubServices().set(getSubServices().indexOf(subService), subService);
            }
            else {
                getSubServices().add(subService);
            }
            if (set) {
                subService.setService(this, false);
            }
        }
    }

    public void removeSubService(SubService subService) {
        getSubServices().remove(subService);
        subService.setService(null);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Service service = (Service) o;
        return id == service.id &&
                Objects.equals(name, service.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }
}
