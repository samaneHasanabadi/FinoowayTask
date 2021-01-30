package ir.samane.homeservicesoft.dto;

import ir.samane.homeservicesoft.model.entity.Customer;
import ir.samane.homeservicesoft.model.entity.SubService;

import java.util.Date;

public class RequestDto {
    private Customer customer;
    private SubService subService;
    private double proposedPrice;
    private Date date;
    private String Address;
    private String description;
}
