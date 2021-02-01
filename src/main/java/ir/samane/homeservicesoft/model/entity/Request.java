package ir.samane.homeservicesoft.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import ir.samane.homeservicesoft.model.enums.RequestStatus;

import javax.persistence.*;
import java.util.*;

@Entity
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String title;
    @ManyToOne
    private Customer customer;
    @OneToOne
    private SubService subService;
    private double proposedPrice;
    private Date date;
    private String Address;
    private String description;
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "request")
    private Set<ExpertOptionMap> expertsOption = new HashSet<>();
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String name) {
        this.title = name;
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

    public Set<ExpertOptionMap> getExpertsOption() {
        return expertsOption;
    }

    public void setExpertsOption(Set<ExpertOptionMap> expertsOption) {
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

    @Override
    public String toString() {
        return "Request{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", customer=" + customer +
                ", date=" + date +
                ", Address='" + Address + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", requestStatus=" + requestStatus +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Request request = (Request) o;
        return id == request.id &&
                Double.compare(request.proposedPrice, proposedPrice) == 0 &&
                Double.compare(request.price, price) == 0 &&
                Objects.equals(title, request.title) &&
                Objects.equals(customer, request.customer) &&
                Objects.equals(subService, request.subService) &&
                Objects.equals(date, request.date) &&
                Objects.equals(Address, request.Address) &&
                Objects.equals(description, request.description) &&
                Objects.equals(expert, request.expert) &&
                requestStatus == request.requestStatus;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, title, customer, subService, proposedPrice, date, Address, description, expert, price, requestStatus);
    }
}
