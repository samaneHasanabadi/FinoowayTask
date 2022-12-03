package ir.samane.finowaytask.service;

import ir.samane.finowaytask.model.dao.WalletDao;
import ir.samane.finowaytask.model.entity.Customer;
import ir.samane.finowaytask.model.entity.Wallet;
import ir.samane.finowaytask.model.entity.WalletTransaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.Optional;

@Service
public class WalletService {

    @Autowired
    WalletDao walletDao;
    @Autowired
    WalletTransactionService walletTransactionService;

    public Wallet save(Wallet wallet){
        return  walletDao.save(wallet);
    }

    public Optional<Wallet> findByCustomer(Integer customerId){
        return walletDao.findByCustomerId(customerId);
    }

    @Transactional
    public String withdraw(Wallet wallet, Customer customer, Double amount) {
        if (amount > wallet.getBalance())
            return "The balance is not enough!";
        Double sum = walletTransactionService.calLastMonthWithdrawals(wallet);
        Double withdrawals = Math.abs(sum != null ? sum : 0d) + amount;
        wallet.setBalance(wallet.getBalance() - amount);
        WalletTransaction transaction = new WalletTransaction();
        transaction.setAmount(amount);
        transaction.setDeposit(false);
        transaction.setCustomer(customer);
        transaction.setWallet(wallet);
        transaction.setRegisterDate(new Date());
        walletTransactionService.save(transaction);
        save(wallet);
        if (wallet.getBalance() <= 0.01 * withdrawals)
            return "Your withdrawal was successful! Your balance is below 1 percent of your last month withdrawals";
        if (wallet.getBalance() <= 0.05 * withdrawals)
            return "Your withdrawal was successful! Your balance is below 5 percent of your last month withdrawals";
        if (wallet.getBalance() <= 0.1 * withdrawals)
            return "Your withdrawal was successful! Your balance is below 10 percent of your last month withdrawals";

        return "Your withdrawal was successful";
    }

    @Transactional
    public void deposit(Wallet wallet, Customer customer, Double amount){
        wallet.setBalance(wallet.getBalance() + amount);
        WalletTransaction transaction = new WalletTransaction();
        transaction.setAmount(amount);
        transaction.setDeposit(true);
        transaction.setCustomer(customer);
        transaction.setWallet(wallet);
        transaction.setRegisterDate(new Date());
        walletTransactionService.save(transaction);
        save(wallet);
    }


}
