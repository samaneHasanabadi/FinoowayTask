package ir.samane.homeservicesoft.model.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Expert extends User{
    @ManyToMany(cascade = CascadeType.ALL, mappedBy = "experts")
    List<SubService> subServices = new ArrayList<>();
    private int score;

    public Expert(){

    }

    public List<SubService> getSubServices() {
        return subServices;
    }

    public void setSubServices(List<SubService> subServices) {
        this.subServices = subServices;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
