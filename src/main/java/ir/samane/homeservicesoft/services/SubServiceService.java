package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.dto.SubServiceDto;
import ir.samane.homeservicesoft.model.dao.SubServiceDao;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.model.enums.RegisterStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class SubServiceService {

    @Autowired
    private SubServiceDao subServiceDao;

    public void addSubService(SubService subService) throws Exception {
        if(subService.getType() == null)
            throw new Exception("نوع زیر خدمت نمی تواند خالی باشد");
        if(subService.getType().getName() == null || subService.getType().getName().equals(""))
            throw new Exception("نام نوع زیر خدمت نمی تواند خالی باشد");
        if(subService.getPrice() <= 0)
            throw new Exception("قیمت زیر خدمت باید بزرگتر از صفر باشد");
        if(subService.getDescription() == null || subService.getDescription().equals(""))
            throw new Exception("توضیحات زیر خدمت نباید خالی باشد");
        subServiceDao.save(subService);
    }

    public List<SubService> getAllSubServices(){
        return subServiceDao.findAll();
    }

    public List<SubService> getSubServicesByExpert(Expert expert) throws Exception {
        if(expert.getStatus().equals(RegisterStatus.APPROVED))
            return subServiceDao.findByExpert(expert);
        else
            throw new Exception("Status of Expert must be Approved");
    }

    public void addExpertToSubService(Expert expert, SubService subService) throws Exception {
        if(subService == null)
            throw new Exception("SubService can not be null");
        if (expert == null)
            throw new Exception("Expert can not be null");
        if(subService.getExperts().contains(expert))
            throw new Exception("SubService already contains this expert");
        subService.getExperts().add(expert);
        subServiceDao.save(subService);
    }

    public SubService findById(int id) throws Exception {
        Optional<SubService> subService = subServiceDao.findById(id);
        if(!subService.isPresent())
            throw new Exception("There is no Sub servce with this id");
        return subService.get();
    }

    public List<SubService> findByService(ir.samane.homeservicesoft.model.entity.Service service) throws Exception {
        if(service == null)
            throw new Exception("Service can not be null");
        return subServiceDao.findByService(service);
    }

    public void removeExpertOfSubService(Expert expert, SubService subService) throws Exception {
        if(expert == null)
            throw new Exception("expert can not be null");
        if(subService == null)
            throw new Exception("Sub service can not be null");
        subService.getExperts().remove(expert);
        subServiceDao.save(subService);
    }

    public void clearExpertList(SubService subService) throws Exception {
        if(subService == null)
            throw new Exception("Sub service can not be null");
        subService.setExperts(new ArrayList<>());
        subServiceDao.save(subService);
    }

    public void deleteSubServiceById(Integer id) throws Exception {
        if(id == null)
            throw new Exception("id can not be null");
        subServiceDao.deleteById(id);
    }

    public List<SubService> findByServiceNameAndSubServiceName(SubServiceDto subServiceDto){
        return subServiceDao.findAll(SubServiceDao.findBy(subServiceDto.getServiceName(),subServiceDto.getSubServiceName()));
    }

//    public List<Expert> getExpertsOfSubService(int id){
//        return subServiceDao.getExpertsOfSubService(id);
//    }
}
