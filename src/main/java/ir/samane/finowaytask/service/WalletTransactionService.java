package ir.samane.finowaytask.service;

import ir.samane.finowaytask.model.dao.WalletTransactionDao;
import ir.samane.finowaytask.model.entity.Wallet;
import ir.samane.finowaytask.model.entity.WalletTransaction;
import org.checkerframework.checker.units.qual.C;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;

@Service
public class WalletTransactionService {

    @Autowired
    WalletTransactionDao walletTransactionDao;

    public WalletTransaction save(WalletTransaction walletTransaction){
        return  walletTransactionDao.save(walletTransaction);
    }

    public Double calLastMonthWithdrawals(Wallet wallet){
        Date date = new Date();
        Calendar instance = Calendar.getInstance();
        instance.setTime(date);
        instance.add(Calendar.DATE, -30);
        Date time = instance.getTime();
        return walletTransactionDao.calcSumWithdrawalsFrom(wallet.getId(), time);
    }

}
