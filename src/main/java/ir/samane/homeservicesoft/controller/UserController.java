package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.model.entity.User;
import ir.samane.homeservicesoft.services.ExpertService;
import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/ajax")
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    ExpertService expertService;
    @RequestMapping(value = "/addUser2", method = RequestMethod.POST)
    public ResponseEntity postEmployeeData(@RequestBody User user) {
        try {
            user = userService.registerUser(user);
            return ResponseEntity.ok(user.getId());
        }catch (Exception exception){
            return ResponseEntity.ok(exception.getMessage());
        }
    }

}
