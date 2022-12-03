package ir.samane.finowaytask.service.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import ir.samane.finowaytask.model.entity.Customer;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ResponseDTO extends ApiResponseDTO {

    private Customer customer;

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
