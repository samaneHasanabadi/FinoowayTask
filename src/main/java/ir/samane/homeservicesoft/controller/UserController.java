package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.dto.MessageDto;
import ir.samane.homeservicesoft.dto.InputDto;
import ir.samane.homeservicesoft.model.entity.Customer;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.services.ConfirmationTokenService;
import ir.samane.homeservicesoft.services.CustomerService;
import ir.samane.homeservicesoft.services.ExpertService;
import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    ConfirmationTokenService confirmationTokenService;
    @Autowired
    ExpertService expertService;
    @Autowired
    CustomerService customerService;

    @GetMapping("/login")
    private String getLoginPage(){
        return "login";
    }

    @GetMapping("/home")
    private String getHomePage(){
        return "home";
    }

    @GetMapping("/signup")
    public String signup(){
        return "signup";
    }

    @RequestMapping(value = "/addUser/EXPERT", method = RequestMethod.POST)
    public @ResponseBody MessageDto registerExpert(@RequestBody Expert expert) {
        MessageDto messageDto = new MessageDto();
        try {
            expert = (Expert) expertService.registerUser(expert);
            messageDto.setId(expert.getId());
            messageDto.setMessage("Expert with name "+ expert.getName() + " " + expert.getFamily() + " is added");
            return messageDto;
        }catch (Exception exception){
            messageDto.setMessage(exception.getMessage());
            return messageDto;
        }
    }

    @RequestMapping(value = "/addUser/CUSTOMER", method = RequestMethod.POST)
    public @ResponseBody MessageDto registerCustomer(@RequestBody Customer customer) {
        MessageDto messageDto = new MessageDto();
        try {
            customer = (Customer) customerService.registerUser(customer);
            messageDto.setId(customer.getId());
            messageDto.setMessage("Customer with name "+ customer.getName() + " " + customer.getFamily() + " is added");
            return messageDto;
        }catch (Exception exception){
            messageDto.setMessage(exception.getMessage());
            return messageDto;
        }
    }

    @RequestMapping(value = "/passwordCheck", method = RequestMethod.POST)
    public ResponseEntity checkPassword(@RequestBody InputDto inputDto) {
       return ResponseEntity.ok(userService.checkPassword(inputDto.getInput()));
    }

    @RequestMapping(value = "/nameCheck", method = RequestMethod.POST)
    public ResponseEntity checkName(@RequestBody InputDto inputDto) {
        return ResponseEntity.ok(userService.checkNameLength(inputDto.getInput()));
    }

    @RequestMapping(value = "/emailCheck", method = RequestMethod.POST)
    public ResponseEntity checkEmail(@RequestBody InputDto inputDto) {
        return ResponseEntity.ok(userService.checkEmail(inputDto.getInput()));
    }

    @RequestMapping(value = "/emailCheckUniqueness", method = RequestMethod.POST)
    public ResponseEntity checkEmailUniqueness(@RequestBody InputDto inputDto) {
        try {
            String message = userService.checkEmailUniqueness(inputDto.getInput());
            return ResponseEntity.ok(message);
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

}
