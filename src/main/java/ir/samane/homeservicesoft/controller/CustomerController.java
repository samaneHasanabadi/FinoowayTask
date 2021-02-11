package ir.samane.homeservicesoft.controller;


import ir.samane.homeservicesoft.model.entity.ConfirmationToken;
import ir.samane.homeservicesoft.services.ConfirmationTokenService;
import ir.samane.homeservicesoft.services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;


@Controller
public class CustomerController {

    private CustomerService customerService;
    private ConfirmationTokenService confirmationTokenService;

    @Autowired
    public void setCustomerService(CustomerService customerService) {
        this.customerService = customerService;
    }

    @Autowired
    public void setConfirmationTokenService(ConfirmationTokenService confirmationTokenService) {
        this.confirmationTokenService = confirmationTokenService;
    }

    @GetMapping("/Customer/ServicePage")
    public String getServicePage(){
        return "CustomerServicePage";
    }

    @GetMapping("/Customer/SubServicePage/{id}")
    public String getSubServicePage(){
        return "CustomerSubServicePage";
    }

    @GetMapping("/Customer/AddRequestPage/{id}")
    public String getAddRequestPage(){
        return "CustomerAddRequestPage";
    }

    @GetMapping("/Customer/RequestPage")
    public String getRequestPage(){
        return "CustomerRequestPage";
    }

    @GetMapping("/Customer/ChooseExpertPage")
    public String getChooseExpertPage(){
        return "CustomerChooseExpertPage";
    }

    @GetMapping("/Customer/PayRequestPage")
    public String getPayRequestPage(){
        return "CustomerPayRequestPage";
    }

    @GetMapping("/Customer/OnlinePaymentPage/{id}")
    public String getOnlinePaymentPage(){
        return "CustomerOnlinePaymentPage";
    }

    @GetMapping("/Customer/CommentPage")
    public String getCommentPage(){
        return "CustomerCommentPage";
    }

    @GetMapping("/Customer/RequestHistory")
    public String getRequestHistoryPage(){
        return "CustomerRequestHistory";
    }

    @GetMapping("/confirm/customer")
    String confirmMail(@RequestParam("token") String token) {
        Optional<ConfirmationToken> optionalConfirmationToken = confirmationTokenService.findConfirmationTokenByToken(token);
        if(optionalConfirmationToken.isPresent()) {
            customerService.confirmUser(optionalConfirmationToken.get());
            return "/CustomerConfirm";
        }else
            return "/ConfirmErrorPage";
    }
}
