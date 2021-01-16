package ir.samane.homeservicesoft.model.entity;

import ir.samane.homeservicesoft.model.enums.RegisterStatus;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Expert extends User{
    private String image;
    @ManyToMany(cascade = CascadeType.ALL, mappedBy = "experts")
    List<SubService> subServices = new ArrayList<>();
    private int score;

    public Expert(){

    }
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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
