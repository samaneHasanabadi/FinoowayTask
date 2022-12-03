package ir.samane.finowaytask.service.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import ir.samane.finowaytask.model.entity.Customer;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class GetAllResponseDTO extends ApiResponseDTO {

    private List<Customer> customerList;

    public List<Customer> getCustomerList() {
        return customerList;
    }

    public void setCustomerList(List<Customer> customerList) {
        this.customerList = customerList;
    }
}
