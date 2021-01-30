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
    private Option option;

}
