package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.model.entity.ConfirmationToken;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.services.ConfirmationTokenService;
import ir.samane.homeservicesoft.services.ExpertService;
import ir.samane.homeservicesoft.services.FileStorageService;
import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@Controller
public class ExpertController {

    private UserService userService;
    private FileStorageService fileStorageService;
    private ConfirmationTokenService confirmationTokenService;
    private ExpertService expertService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired
    public void setFileStorageService(FileStorageService fileStorageService) {
        this.fileStorageService = fileStorageService;
    }

    @Autowired
    public void setConfirmationTokenService(ConfirmationTokenService confirmationTokenService) {
        this.confirmationTokenService = confirmationTokenService;
    }

    @Autowired
    public void setExpertService(ExpertService expertService) {
        this.expertService = expertService;
    }

    @GetMapping("/Expert/RequestPage")
    public String getRequestPage(){
        return "ExpertRequestPage";
    }

    @GetMapping("/Expert/ApproveRequestPage")
    public String getApproveRequestPage(){
        return "ExpertApproveRequestPage";
    }

    @PostMapping("/uploadFile/{id}")
    public ResponseEntity uploadFile(@RequestParam("file") MultipartFile file, @PathVariable("id") int id) {
        try {
            fileStorageService.storeFile(file, id);
            return ResponseEntity.ok("/home/samane/IdeaProjects/HomeServiceSoft/src/main/webapp/WEB-INF/jsp/resources/static/images/" + id+".jpg");
        } catch (Exception exception) {
            return ResponseEntity.status(400).body(exception.getMessage());
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

    @GetMapping("/Expert/ProfilePage")
    public String getExpertPage(){
        return "ExpertServicePage";
    }
}
