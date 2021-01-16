package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.ServiceDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServiceService {

    @Autowired
    ServiceDao serviceDao;

    public void addService(ir.samane.homeservicesoft.model.entity.Service service) throws Exception {
        if(service.getType() == null)
            throw new Exception("تایپ خدمت نمی تواند خالی باشد");
        if(service.getType().getName() == null || service.getType().getName().equals(""))
            throw new Exception("نام نوع خدمت نمی تواند خالی باشد");
        serviceDao.save(service);
    }

    public List<ir.samane.homeservicesoft.model.entity.Service> getAllServices(){
        return serviceDao.findAll();
    }

    public ir.samane.homeservicesoft.model.entity.Service getServiceById(int id) throws Exception {
       if(serviceDao.findById(id).isPresent())
           return serviceDao.findById(id).get();
       else
           throw new Exception("با این شناسه خدمتی پیدا نشد");
    }

    public void deleteServiceById(Integer id) throws Exception {
        if(id == null)
            throw new Exception("id can not be null");
        serviceDao.deleteById(id);
    }
}
