package ir.samane.finowaytask.controller;

import ir.samane.finowaytask.model.entity.Customer;
import ir.samane.finowaytask.service.CustomerService;
import ir.samane.finowaytask.service.WalletService;
import ir.samane.finowaytask.service.dto.ApiResponseDTO;
import ir.samane.finowaytask.service.dto.WalletDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/wallet")
public class WalletController {

    @Autowired
    WalletService walletService;
    @Autowired
    CustomerService customerService;

    @PostMapping(value = "/withdraw")
    public ResponseEntity<ApiResponseDTO> withdraw(WalletDTO walletDto) {
        ApiResponseDTO response = new ApiResponseDTO();
        Customer customer = null;
        try {
            customer = customerService.findById(walletDto.getCustomerId());
        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage("Customer not found");
            return ResponseEntity.ok().body(response);
        }
        response.setMessage(walletService.withdraw(customer.getWallet(), customer,  walletDto.getAmount()));
        response.setSuccess(true);
        return ResponseEntity.ok().body(response);
    }

    @PostMapping(value = "/deposit")
    public ResponseEntity deposit(WalletDTO walletDto) {
        ApiResponseDTO response = new ApiResponseDTO();
        Customer customer = null;
        try {
            customer = customerService.findById(walletDto.getCustomerId());
        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage("Customer not found");
            return ResponseEntity.ok().body(response);
        }
        walletService.deposit(customer.getWallet(), customer, walletDto.getAmount());
        response.setMessage("Your balance charged");
        response.setSuccess(true);
        return ResponseEntity.ok().body(response);
    }

    @GetMapping("/depositWithdrawPage")
    public String getServicePage(){
        return "CustomerWalletPage";
    }

}
