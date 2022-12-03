package ir.samane.finowaytask.service;

import ir.samane.finowaytask.model.dao.CustomerDao;
import ir.samane.finowaytask.model.entity.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerService {

    @Autowired
    CustomerDao customerDao;
    @Autowired
    WalletService walletService;

    public Customer save(Customer customer) {
        walletService.save(customer.getWallet());
        return customerDao.save(customer);
    }

    public void deleteById(Integer id) throws Exception {
        Optional<Customer> byId = customerDao.findById(id);
        if (byId.isEmpty())
            throw new Exception("Customer with id " + id + " does not exist!");
        customerDao.deleteById(id);
    }

    public Customer findById(Integer id) throws Exception {
        Optional<Customer> byId = customerDao.findById(id);
        if (byId.isPresent())
            return byId.get();
        throw new Exception("Customer with id " + id + " does not exist!");
    }

    public Optional<Customer> findByWalletId(Integer walletId) {
        return customerDao.findByWalletId(walletId);
    }

    public List<Customer> saveAll(List<Customer> customerList) {
        return customerDao.saveAll(customerList);
    }

    @Cacheable("findAllCustomerCache")
    public List<Customer> findAll(Customer customer) {
        return customerDao.findAll(customerDao.findBy(customer));
    }


}
