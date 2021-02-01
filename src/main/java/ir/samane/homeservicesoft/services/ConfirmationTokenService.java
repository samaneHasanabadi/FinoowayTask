package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.ConfirmationTokenDao;
import ir.samane.homeservicesoft.model.entity.ConfirmationToken;
import ir.samane.homeservicesoft.model.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
public class ConfirmationTokenService {
    private ConfirmationTokenDao confirmationTokenDao;

    @Autowired
    public void setConfirmationTokenDao(ConfirmationTokenDao confirmationTokenDao) {
        this.confirmationTokenDao = confirmationTokenDao;
    }

    public ConfirmationTokenService() {
        confirmationTokenDao = null;
    }

    void saveConfirmationToken(ConfirmationToken confirmationToken) {
        confirmationTokenDao.save(confirmationToken);
    }

    void deleteConfirmationToken(Integer id){
        confirmationTokenDao.deleteById(id);
    }

    public Optional<ConfirmationToken> findConfirmationTokenByToken(String token) {
        Optional<ConfirmationToken> byConfirmationToken = confirmationTokenDao.findByConfirmationToken(token);
        return byConfirmationToken;
    }

    public Optional<ConfirmationToken> findByUser(User user){
        return confirmationTokenDao.findByUser(user);
    }
}
