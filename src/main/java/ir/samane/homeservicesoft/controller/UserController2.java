package ir.samane.homeservicesoft.controller;

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
public class UserController2 {
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

    @GetMapping("signup")
    public String signup(){
        return "signup";
    }

    @RequestMapping(value = "/addUser/EXPERT", method = RequestMethod.POST)
    public ResponseEntity registerExpert(@RequestBody Expert expert) {
        try {
            expert = (Expert) expertService.registerUser(expert);
            return ResponseEntity.ok(expert.getId());
        }catch (Exception exception){
            return ResponseEntity.ok(exception.getMessage());
        }
    }

    @RequestMapping(value = "/addUser/CUSTOMER", method = RequestMethod.POST)
    public ResponseEntity regiserCustomer(@RequestBody Customer customer) {
        try {
            customer = (Customer) customerService.registerUser(customer);
            return ResponseEntity.ok(customer.getId());
        }catch (Exception exception){
            return ResponseEntity.ok(exception.getMessage());
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
