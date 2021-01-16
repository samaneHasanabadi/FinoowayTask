package ir.samane.homeservicesoft.facade;

import ir.samane.homeservicesoft.exceptions.ExpertStatusException;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.model.enums.RegisterStatus;
import ir.samane.homeservicesoft.services.ExpertService;
import ir.samane.homeservicesoft.services.ServiceService;
import ir.samane.homeservicesoft.services.SubServiceService;
import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ManagerFacade {
    @Autowired
    ExpertService expertService;
    @Autowired
    UserService userService;
    @Autowired
    ServiceService serviceService;
    @Autowired
    SubServiceService subServiceService;

    public void approveAllWaitingExperts(){
        List<Expert> experts = expertService.getExpertsByStatus(RegisterStatus.WAITING);
        experts.forEach(expert -> {expert.setStatus(RegisterStatus.APPROVED);
                                    expertService.saveExpert(expert);});
    }

    public void approveWaitingExpert(int id) throws Exception {
        Expert expert = expertService.findById(id);
        if(expert.getStatus().equals(RegisterStatus.WAITING)) {
            expert.setStatus(RegisterStatus.APPROVED);
            expertService.saveExpert(expert);
        }else {
            throw new ExpertStatusException("status of expert should be waiting for approval");
        }
    }

    public Expert addExpert(Expert expert) throws Exception {
        expert.setStatus(RegisterStatus.APPROVED);
        return (Expert) userService.registerUser(expert);
    }

    public List<SubService> getSubServicesOfExpert(int id) throws Exception {
        Expert expert = expertService.findById(id);
        return subServiceService.getSubServicesByExpert(expert);
    }

    public void addSubServiceToExpert(int expertId, int subServiceId) throws Exception {
        Expert expert = expertService.findById(expertId);
        SubService subService = subServiceService.findById(subServiceId);
        subServiceService.addExpertToSubService(expert,subService);
    }

    public List<SubService> findSubServicesByServiceId(int serviceId) throws Exception {
        ir.samane.homeservicesoft.model.entity.Service service =
                serviceService.getServiceById(serviceId);
        return subServiceService.findByService(service);
    }

    public void removeExpertOfSubService(int expertId, int subServiceID) throws Exception {
        Expert expert = expertService.findById(expertId);
        SubService subService = subServiceService.findById(subServiceID);
        subServiceService.removeExpertOfSubService(expert, subService);
    }

    public void clearExpertListOfSubService(int subServiceId) throws Exception {
        SubService subService = subServiceService.findById(subServiceId);
        subServiceService.clearExpertList(subService);
    }

    public void clearSubServiceListOfExpert(int expertId) throws Exception {
        Expert expert = expertService.findById(expertId);
        expertService.clearSubServiceList(expert);
    }

    public List<Expert> getUnUsedExpertsOfSubService(int subServiceId) throws Exception {
        List<Expert> allExperts = expertService.getAllExperts();
        List<Expert> expertsOfSubService = getExpertsOfSubServiceById(subServiceId);
        return allExperts.stream().filter(subService1 -> subService1.getStatus()
                .equals(RegisterStatus.APPROVED)).
                filter(subService1 -> !expertsOfSubService.contains(subService1)).
                collect(Collectors.toList());
    }

    public List<Expert> getExpertsOfSubServiceById(int subServiceId) throws Exception {
        SubService subService = subServiceService.findById(subServiceId);
        return expertService.findBySubService(subService);
    }

}

