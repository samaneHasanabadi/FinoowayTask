package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.ConfirmationToken;
import ir.samane.homeservicesoft.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ConfirmationTokenDao extends JpaRepository<ConfirmationToken,Integer> {
    Optional<ConfirmationToken> findByConfirmationToken(String token);
    Optional<ConfirmationToken> findByUser(User user);
}
