package ir.samane.finowaytask.model.dao;

import ir.samane.finowaytask.model.entity.Wallet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface WalletDao extends JpaRepository<Wallet, Integer>, JpaSpecificationExecutor<Wallet> {

    @Query("SELECT customer.wallet FROM Customer  customer WHERE customer.id = :customerId")
    Optional<Wallet> findByCustomerId(@Param("customerId") Integer customerId);


}
