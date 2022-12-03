package ir.samane.finowaytask.controller;

import ir.samane.finowaytask.model.entity.Customer;
import ir.samane.finowaytask.model.entity.Wallet;
import ir.samane.finowaytask.service.CustomerMapper;
import ir.samane.finowaytask.service.CustomerService;
import ir.samane.finowaytask.service.WalletService;
import ir.samane.finowaytask.service.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/customer")
public class CustomerController {

    @Autowired
    CustomerService customerService;
    @Autowired
    CustomerMapper customerMapper;
    @Autowired
    WalletService walletService;

    @PostMapping(value = "/create")
    public ResponseEntity<ResponseDTO> getCheapestTickets(@RequestBody CustomerDTO dto) {
        ResponseDTO response = new ResponseDTO();
        Customer save = customerService.save(customerMapper.map(dto));
        if (save.getId() != null) {
            response.setSuccess(true);
            response.setMessage("Customer " + save.getName() + " has been created!");
        } else {
            response.setSuccess(false);
            response.setMessage("Customer could not be created!");
        }
        response.setCustomer(save);
        return ResponseEntity.ok().body(response);
    }

    @DeleteMapping(value = "/delete/{id}")
    public ResponseEntity<ApiResponseDTO> deleteById(@PathVariable Integer id) {
        ApiResponseDTO response = new ApiResponseDTO();
        try {
            customerService.deleteById(id);
            response.setSuccess(true);
            response.setMessage("Customer With id " + id + " has been deleted");
        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage(e.getMessage());
        }
        return ResponseEntity.ok().body(response);
    }

    @GetMapping(value = "/getAll")
    public ResponseEntity<GetAllResponseDTO> getAllCustomers() {
        GetAllResponseDTO response = new GetAllResponseDTO();
        response.setCustomerList(customerService.findAll(null));
        return ResponseEntity.ok().body(response);
    }

    @GetMapping(value = "/get/{id}")
    public ResponseEntity<ResponseDTO> getCustomerByID(@PathVariable Integer id) {
        ResponseDTO response = new ResponseDTO();
        try {
            response.setCustomer(customerService.findById(id));
            response.setSuccess(true);
        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage(e.getMessage());
        }
        return ResponseEntity.ok().body(response);
    }

    @GetMapping("/createPage")
    public String getServicePage(){
        return "CustomerPage";
    }

}
