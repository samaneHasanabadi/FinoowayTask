package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.model.entity.User;
import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;

@Controller
public class SecurityController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/getUserId", method = RequestMethod.GET)
    @ResponseBody
    public int currentUserName(Principal principal) {
        String userName = principal.getName();
        try {
            User user = userService.getUserByEmail(userName);
            System.out.println(user.getId());
            return user.getId();
        }catch (Exception e){
            return 0;
        }
    }
}
