package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.ExpertDao;
import ir.samane.homeservicesoft.model.entity.ConfirmationToken;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.model.entity.User;
import ir.samane.homeservicesoft.model.enums.RegisterStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ExpertService extends UserService {

    @Autowired
    private ExpertDao expertDao;
    @Autowired
    private ConfirmationTokenService confirmationTokenService;
    @Autowired
    private EmailSenderService emailSenderService;

    public Expert saveExpert(User expert){
        Expert save = expertDao.save((Expert) expert);
        return save;
    }

    public void saveExpert(Expert expert){
        expertDao.save(expert);
    }

    @Override
    public User registerUser(User user) throws Exception {
        User save = super.registerUser(user);
        Expert expert = (Expert) user;
        expert.setStatus(RegisterStatus.REGISTERED);
        expertDao.save(expert);
        final ConfirmationToken confirmationToken = new ConfirmationToken(expert);
        confirmationTokenService.saveConfirmationToken(confirmationToken);
        sendConfirmationMail(user.getEmail(), confirmationToken.getConfirmationToken());
        return save;
    }

    public Expert findById(int id) throws Exception {
        Optional<Expert> byId = expertDao.findById(id);
        if(!byId.isPresent())
            throw new Exception("There is no expert with this id");
        Expert expert = byId.get();
        return expert;
    }

    public void confirmUser(ConfirmationToken confirmationToken) {
        final Expert expert = (Expert) confirmationToken.getUser();
        expert.setStatus(RegisterStatus.WAITING);
        expertDao.save(expert);
        confirmationTokenService.deleteConfirmationToken(confirmationToken.getId());
    }

    public void sendConfirmationMail(String userMail, String token) {
        final SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(userMail);
        mailMessage.setSubject("Mail Confirmation Link!");
        mailMessage.setFrom("<MAIL>");
        mailMessage.setText(
                "Thank you for registering. Please click on the below link to activate your account.\n" + "http://localhost:8080/confirm?token="
                        + token);
        emailSenderService.sendEmail(mailMessage);
    }

    public List<Expert> getExpertsByStatus (RegisterStatus registerStatus){
        return expertDao.findByStatus(registerStatus);
    }

    public List<Expert> getAllExperts(){
        return expertDao.findAll();
    }

    public void clearSubServiceList(Expert expert) throws Exception {
        if(expert == null)
            throw new Exception("expert can not be null");
        expert.setSubServices(new ArrayList<>());
        expertDao.save(expert);
    }

    public List<Expert> findBySubService(SubService subService){
        return expertDao.findBySubService(subService);
    }



}
