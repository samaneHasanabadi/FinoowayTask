package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.ServiceDao;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
import ir.samane.homeservicesoft.model.entity.Service;

import java.util.List;

@org.springframework.stereotype.Service
public class ServiceService {

    @Autowired
    ServiceDao serviceDao;

    public void addService(Service service) throws Exception {
        if (service.getType() == null)
            throw new Exception("Type can not be null");
        if (service.getType().getName() == null || service.getType().getName().equals(""))
            throw new Exception("Type name can not be null");
        serviceDao.save(service);
    }

    public List<Service> getAllServices() {
        return serviceDao.findAll();
    }

    public Service getServiceById(int id) throws Exception {
        if (serviceDao.findById(id).isPresent())
            return serviceDao.findById(id).get();
        else
            throw new Exception("No service found with this id");
    }

    public void deleteServiceById(Integer id) throws Exception {
        if (id == null)
            throw new Exception("id can not be null");
        serviceDao.deleteById(id);
    }
}
