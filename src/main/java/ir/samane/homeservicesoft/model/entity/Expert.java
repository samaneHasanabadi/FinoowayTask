package ir.samane.homeservicesoft.model.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Expert extends User{

    @ManyToMany(cascade = CascadeType.ALL, mappedBy = "experts")
    List<SubService> subServices = new ArrayList<>();
    private int score;
    private double credit;
    @OneToMany
    private List<Request> requests = new ArrayList<>();

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

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public List<Request> getRequests() {
        return requests;
    }

    public void setRequests(List<Request> requests) {
        this.requests = requests;
    }
}
