package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.model.entity.ConfirmationToken;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.services.ConfirmationTokenService;
import ir.samane.homeservicesoft.services.ExpertService;
import ir.samane.homeservicesoft.services.FileStorageService;
import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.servlet.WebMvcAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@Controller
public class ExpertController {
    @Autowired
    UserService userService;
    @Autowired
    private FileStorageService fileStorageService;
    @Autowired
    ConfirmationTokenService confirmationTokenService;
    @Autowired
    ExpertService expertService;

    @PostMapping("/uploadFile/{id}")
    public ResponseEntity uploadFile(@RequestParam("file") MultipartFile file, @PathVariable("id") int id) {
        try {
            String expertName = fileStorageService.storeFile(file, id);
            return ResponseEntity.ok("image of expert " + expertName + " is added!");
        } catch (Exception exception) {
            return ResponseEntity.ok(exception.getMessage());
        }
    }

    @GetMapping("/getAllExperts")
    public @ResponseBody List<Expert> getAllExperts(){
        return expertService.getAllExperts();
    }

    @GetMapping("/confirm")
    String confirmMail(@RequestParam("token") String token) {
        Optional<ConfirmationToken> optionalConfirmationToken = confirmationTokenService.findConfirmationTokenByToken(token);
        if(optionalConfirmationToken.isPresent()) {
            expertService.confirmUser(optionalConfirmationToken.get());
            return "/confirm";
        }else
            return "/ConfirmErrorPage";
    }

    @GetMapping("/Expert/Page")
    public String getExpertPage(){
        return "ExpertPage";
    }
}
