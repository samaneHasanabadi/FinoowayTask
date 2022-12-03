package ir.samane.finowaytask.model.dao;

import ir.samane.finowaytask.model.entity.Wallet;
import ir.samane.finowaytask.model.entity.WalletTransaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.Optional;

@Repository
public interface WalletTransactionDao extends JpaRepository<WalletTransaction, Integer>, JpaSpecificationExecutor<WalletTransaction> {

    @Query("SELECT SUM(transaction.amount) FROM WalletTransaction transaction WHERE transaction.wallet.id = :walletId AND transaction.isDeposit = false AND transaction.registerDate >= :date")
    Double calcSumWithdrawalsFrom(@Param("walletId") Integer walletId, @Param("date") Date date);
}
