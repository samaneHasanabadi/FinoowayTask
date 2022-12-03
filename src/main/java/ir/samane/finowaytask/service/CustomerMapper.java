package ir.samane.finowaytask.service;

import ir.samane.finowaytask.model.entity.Customer;
import ir.samane.finowaytask.model.entity.Wallet;
import ir.samane.finowaytask.service.dto.CustomerDTO;
import org.springframework.stereotype.Service;

@Service
public class CustomerMapper {

    public Customer map(CustomerDTO customerDTO) {
        Customer customer = new Customer();
        customer.setName(customerDTO.getName());
        customer.setWallet(new Wallet());
        return customer;
    }
}
