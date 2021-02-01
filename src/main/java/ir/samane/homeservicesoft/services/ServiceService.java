package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.ServiceDao;
import ir.samane.homeservicesoft.model.entity.Category;
import org.springframework.beans.factory.annotation.Autowired;
import ir.samane.homeservicesoft.model.entity.Service;

import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service
public class ServiceService {

    private ServiceDao serviceDao;
    private int maxLength = 26;

    @Autowired
    public void setServiceDao(ServiceDao serviceDao) {
        this.serviceDao = serviceDao;
    }

    public void addService(Service service) throws Exception {
        checkNullField(service.getName(), "name");
        checkServiceType(service.getType());
        checkNullField(service.getType().getName(), "Type name");
        checkFieldLength(service.getName(), "name");
        checkFieldLength(service.getType().getName(), "Type name");
        checkServiceNameUniqueness(service.getName());
        serviceDao.save(service);
    }

    public Optional<Service> findByName(String name){
        return serviceDao.findByName(name);
    }

    public void checkServiceNameUniqueness(String name) throws Exception {
        Optional<Service> service = findByName(name);
        if(service.isPresent())
            throw new Exception("Service name is duplicated");
    }

    public void checkFieldLength(String field, String fieldName) throws Exception {
        if(field.length() > maxLength)
            throw new Exception("Length of service " + fieldName + " must less than " + maxLength + " characters");
    }

    public void checkServiceType(Category category) throws Exception {
        if(category == null)
            throw new Exception("Service Type can not be null");
    }

    public void checkNullField(String field, String fieldName) throws Exception {
        if(field == null || field.equals(""))
            throw new Exception("Service " + fieldName + " can not be null");
    }

    public List<Service> getAllServices() {
        return serviceDao.findAll();
    }

    public Service getServiceById(int id) throws Exception {
        Optional<Service> service = serviceDao.findById(id);
        if (service.isPresent())
            return service.get();
        else
            throw new Exception("No service found with this id");
    }

    public void deleteServiceById(Integer id) throws Exception {
        if (id == null)
            throw new Exception("id can not be null");
        serviceDao.deleteById(id);
    }
}
