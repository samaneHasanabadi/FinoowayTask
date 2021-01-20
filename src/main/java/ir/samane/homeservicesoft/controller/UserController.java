package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.dto.MessageDto;
import ir.samane.homeservicesoft.model.entity.Customer;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.User;
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



//    @PostMapping(value = "/lo",consumes = MediaType.APPLICATION_JSON_VALUE)
//    @ResponseBody
//    public ResponseEntity registerStudent(@RequestBody User user){
//        userService.registerUser(user);
//        return ResponseEntity.ok("New User with " + user.getEmail() + " is added!");
//    }
//
//    @PostMapping
//    @ResponseBody
//    public ResponseEntity saveAdmin(@RequestBody User user){
//                userService.registerUser(user);
//                return ResponseEntity.ok("New Admin with " + user.getEmail() + " is added!");
//    }
}
