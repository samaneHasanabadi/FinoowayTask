package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.dto.SubServiceDto;
import ir.samane.homeservicesoft.model.dao.SubServiceDao;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.Service;
import ir.samane.homeservicesoft.model.entity.SubCategory;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.model.enums.RegisterStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service
public class SubServiceService {

    private SubServiceDao subServiceDao;
    private int maxLength = 30;
    private int pageSize = 2;

    @Autowired
    public void setSubServiceDao(SubServiceDao subServiceDao) {
        this.subServiceDao = subServiceDao;
    }

    public void addSubService(SubService subService) throws Exception {
        checkTypeNull(subService.getType());
        checkFieldNull(subService.getName(), "name");
        checkFieldLength(subService.getName(), "name");
        checkFieldNull(subService.getDescription(), "description");
        checkPrice(subService.getPrice());
        checkFieldNull(subService.getType().getName(), "type name");
        checkFieldLength(subService.getType().getName(), "type name");
        checkSubServiceNameUniqueness(subService.getName());
        subServiceDao.save(subService);
    }

    public void checkFieldLength(String field, String fieldName) throws Exception {
        if(field.length() > maxLength)
            throw new Exception("Length of sub service " + fieldName + " must less than " + maxLength + " characters");
    }

    public Optional<SubService> findByName(String name) throws Exception {
        checkFieldNull(name, "name");
        return subServiceDao.findByName(name);
    }

    public void checkSubServiceNameUniqueness(String name) throws Exception {
        Optional<SubService> subService = findByName(name);
        if(subService.isPresent())
            throw new Exception("Sub service with name " + name + " is already exists");
    }

    public void checkEditSubServiceNameUniqueness(String editName, String name) throws Exception {
        if(!editName.equals(name)) {
            checkSubServiceNameUniqueness(editName);
        }
    }

    public void checkFieldNull(String field, String fieldName) throws Exception {
        if(field == null || field.equals(""))
            throw new Exception("Sub service " + fieldName + " can not be null or empty");
    }

    public void checkTypeNull(SubCategory subCategory) throws Exception {
        if(subCategory == null)
            throw new Exception("Sub service Type can not be null");
    }

    public void checkPrice(double price) throws Exception {
        if(price <= 0)
            throw new Exception("Price must be bigger than zero");
    }

    public Page<SubService> getAllSubServices(int pageNumber){
        Pageable page = PageRequest.of(pageNumber, pageSize);
        return subServiceDao.findAll(page);
    }

    public List<SubService> getSubServicesByExpert(Expert expert) throws Exception {
        if(expert.getStatus().equals(RegisterStatus.APPROVED))
            return subServiceDao.findByExpert(expert);
        else
            throw new Exception("Status of Expert must be Approved");
    }

    public void addExpertToSubService(Expert expert, SubService subService) throws Exception {
        checkSubServiceNull(subService);
        checkExpertNull(expert);
        checkSubServiceHavingExpert(subService, expert);
        subService.getExperts().add(expert);
        subServiceDao.save(subService);
    }

    public void checkSubServiceNull(SubService subService) throws Exception {
        if(subService == null)
            throw new Exception("SubService can not be null");
    }

    public void checkExpertNull(Expert expert) throws Exception {
        if (expert == null)
            throw new Exception("Expert can not be null");
    }

    public void checkSubServiceHavingExpert(SubService subService, Expert expert) throws Exception {
        if(subService.getExperts().contains(expert))
            throw new Exception("SubService already contains this expert");
    }

    public SubService findById(int id) throws Exception {
        Optional<SubService> subService = subServiceDao.findById(id);
        if(!subService.isPresent())
            throw new Exception("There is no Sub service with this id");
        return subService.get();
    }

    public List<SubService> findByService(Service service) throws Exception {
        checkServiceNull(service);
        return subServiceDao.findByService(service);
    }

    public void checkServiceNull(Service service) throws Exception {
        if(service == null)
            throw new Exception("Service can not be null");
    }

    public void removeExpertOfSubService(Expert expert, SubService subService) throws Exception {
        checkExpertNull(expert);
        checkSubServiceNull(subService);
        subService.getExperts().remove(expert);
        subServiceDao.save(subService);
    }

    public void clearExpertList(SubService subService) throws Exception {
        checkSubServiceNull(subService);
        subService.setExperts(new ArrayList<>());
        subServiceDao.save(subService);
    }

    public void deleteSubServiceById(int id) throws Exception {
        SubService subService = findById(id);
        checkSubServiceHasExperts(subService);
        subServiceDao.deleteById(id);
    }

    public void checkSubServiceHasExperts(SubService subService) throws Exception {
        if(subService.getExperts().size() > 0)
            throw new Exception("Sub Service "+subService.getName()+" has expert and can not be deleted");
    }

    public List<SubService> findByServiceNameAndSubServiceName(SubServiceDto subServiceDto){
        return subServiceDao.findAll(SubServiceDao.findBy(subServiceDto.getServiceName(),subServiceDto.getSubServiceName()));
    }

    public void editSubService(SubService subService) throws Exception {
        checkTypeNull(subService.getType());
        checkFieldNull(subService.getName(), "name");
        checkFieldLength(subService.getName(), "name");
        checkFieldNull(subService.getDescription(), "description");
        checkPrice(subService.getPrice());
        checkFieldNull(subService.getType().getName(), "type name");
        checkFieldLength(subService.getType().getName(), "type name");
        SubService oldSubService = findById(subService.getId());
        checkEditSubServiceNameUniqueness(subService.getName(), oldSubService.getName());
        oldSubService.setName(subService.getName());
        oldSubService.setService(subService.getService());
        oldSubService.setDescription(subService.getDescription());
        oldSubService.setPrice(subService.getPrice());
        oldSubService.setType(subService.getType());
        subServiceDao.save(oldSubService);
    }

}
