package ir.samane.homeservicesoft.model.entity;

import javax.persistence.*;

@Entity
public class ExpertOptionMap {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @OneToOne
    private Expert expert;
    @OneToOne
    private Option2 option;
    @ManyToOne
    private Request request;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public Option2 getOption() {
        return option;
    }

    public void setOption(Option2 option) {
        this.option = option;
    }

    public Request getRequest() {
        return request;
    }

    public void setRequest(Request request) {
        this.request = request;
    }
}
