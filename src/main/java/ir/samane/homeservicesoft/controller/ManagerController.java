package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.dto.MessageDto;
import ir.samane.homeservicesoft.dto.UserDto;
import ir.samane.homeservicesoft.facade.ManagerFacade;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class ManagerController {

    @Autowired
    ManagerFacade managerFacade;

    @Autowired
    UserService userService;

    @GetMapping("/Manager/ShowExpertPage")
    private String getManagerShowExpertPage(){
        return "ManagerShowExpertPage";
    }

    @GetMapping("/Manager/ExpertPage")
    private String getManagerExpertPage(){
        return "ManagerExpertPage";
    }

    @GetMapping("/Manager/ShowServicePage")
    private String getManagerShowServicePage(){
        return "ManagerShowServicePage";
    }

    @GetMapping("/approveAllWaitingExperts")
    private ResponseEntity approveAllWaitingExperts(){
        managerFacade.approveAllWaitingExperts();
        return ResponseEntity.ok("All Waiting Experts approved");
    }

    @RequestMapping(value = "/addExpert", method = RequestMethod.POST)
    public @ResponseBody MessageDto registerExpert(@RequestBody Expert expert) {
        MessageDto messageDto = new MessageDto();
        try {
            expert = managerFacade.addExpert(expert);
            messageDto.setId(expert.getId());
            messageDto.setMessage("Expert with name "+ expert.getName() + " " + expert.getFamily() + " is added");
            return messageDto;
        }catch (Exception exception){
            messageDto.setMessage(exception.getMessage());
            return messageDto;
        }
    }

    @RequestMapping(value = "/approveExpert/{id}", method = RequestMethod.PUT)
    public ResponseEntity approveExpert(@PathVariable("id") int id) {
        try {
            managerFacade.approveWaitingExpert(id);
            return ResponseEntity.ok(id);
        }catch (Exception exception){
            return ResponseEntity.ok(exception.getMessage());
        }
    }

    @GetMapping("/getSubServicesOfExpert/{id}")
    public @ResponseBody List<SubService> getAllSubServices(@PathVariable("id") int id){
        try {
            return managerFacade.getSubServicesOfExpert(id);
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
            return null;
        }
    }

    @GetMapping("/addExpertToSubService/{expertId}/{subServiceId}")
    public ResponseEntity addExpertToSubService(@PathVariable("expertId") int expertId, @PathVariable("subServiceId") int subServiceId){
        try {
            managerFacade.addSubServiceToExpert(expertId,subServiceId);
            return ResponseEntity.ok("subService add to Expert Successfully");
        } catch (Exception exception) {
            return ResponseEntity.ok(exception.getMessage());
        }
    }

    @GetMapping("/getSubServicesOfService/{serviceId}")
    public  @ResponseBody List<SubService> getSubServicesOfService(@PathVariable("serviceId") int serviceId){
        try {
            return managerFacade.findSubServicesByServiceId(serviceId);
        } catch (Exception exception) {
            return null;
        }
    }

    @GetMapping("/removeExpertOfSubService/{expertId}/{subServiceId}")
    public ResponseEntity removeExpertOfSubService(@PathVariable("expertId") int expertId, @PathVariable("subServiceId") int subServiceId){
        try {
            managerFacade.removeExpertOfSubService(expertId,subServiceId);
            return ResponseEntity.ok("expert removed from subService Successfully");
        } catch (Exception exception) {
            return ResponseEntity.ok(exception.getMessage());
        }
    }

    @GetMapping("/clearExpertListOfSubService/{subServiceId}")
    public ResponseEntity clearExpertListOfSubService(@PathVariable("subServiceId") int subServiceId){
        try {
            managerFacade.clearExpertListOfSubService(subServiceId);
            return ResponseEntity.ok("expert list removed from subService Successfully");
        } catch (Exception exception) {
            return ResponseEntity.ok(exception.getMessage());
        }
    }

    @GetMapping("/clearSubServiceListOfExpert/{expertId}")
    public ResponseEntity clearSubServiceListOfExpert(@PathVariable("expertId") int expertId){
        try {
            managerFacade.clearSubServiceListOfExpert(expertId);
            return ResponseEntity.ok("subService list removed from expert Successfully");
        } catch (Exception exception) {
            return ResponseEntity.ok(exception.getMessage());
        }
    }

    @GetMapping("/Manager/ServicePage")
    public String ManagerServicePage(){
        return "ManagerServicePage";
    }

    @GetMapping("/getUnUsedExpertsOfSubService/{id}")
    public @ResponseBody List<Expert> getUnUsedExpertsOfSubService(@PathVariable("id") int id){
        try {
            return managerFacade.getUnUsedExpertsOfSubService(id);
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
            return null;
        }
    }

    @GetMapping("/getExpertsOfSubService/{subServiceId}")
    public @ResponseBody List<Expert> getExpertsOfSubService(@PathVariable("subServiceId") int subServiceId){
        try {
            return managerFacade.getExpertsOfSubServiceById(subServiceId);
        } catch (Exception exception) {
            return null;
        }
    }

    @PostMapping("/findByCriteria")
    public @ResponseBody List<Expert> findByCriteria(@RequestBody UserDto userDto){
        return userService.findBy(userDto);
    }

    @GetMapping("/Manager/SearchPage")
    public String getManagerSearchPage(){
        return "ManagerSearchPage";
    }

}
