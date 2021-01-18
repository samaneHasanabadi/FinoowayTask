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

    @Autowired
    CustomerService customerService;
    @Autowired
    ConfirmationTokenService confirmationTokenService;

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
