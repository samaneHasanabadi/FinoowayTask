package ir.samane.homeservicesoft.model.entity;

import ir.samane.homeservicesoft.model.enums.RequestStatus;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    private Customer customer;
    @OneToOne
    private SubService subService;
    private double proposedPrice;
    private Date date;
    private String Address;
    private String description;
    @OneToMany
    private List<ExpertOptionMap> expertsOption;
    @ManyToOne
    private Expert expert;
    private double price;
    @Enumerated(value = EnumType.STRING)
    private RequestStatus requestStatus;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public SubService getSubService() {
        return subService;
    }

    public void setSubService(SubService subService) {
        this.subService = subService;
    }

    public double getProposedPrice() {
        return proposedPrice;
    }

    public void setProposedPrice(double proposedPrice) {
        this.proposedPrice = proposedPrice;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String address) {
        Address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ExpertOptionMap> getExpertsOption() {
        return expertsOption;
    }

    public void setExpertsOption(List<ExpertOptionMap> expertsOption) {
        this.expertsOption = expertsOption;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public RequestStatus getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(RequestStatus requestStatus) {
        this.requestStatus = requestStatus;
    }
}
