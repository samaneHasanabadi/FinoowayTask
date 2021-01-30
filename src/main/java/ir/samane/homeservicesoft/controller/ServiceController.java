package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.dto.InputDto;
import ir.samane.homeservicesoft.dto.SubServiceDto;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.Service;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.services.ServiceService;
import ir.samane.homeservicesoft.services.SubServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class ServiceController {

    @Autowired
    ServiceService serviceService;
    @Autowired
    SubServiceService subServiceService;

    @GetMapping("/ManagerPage")
    public String getManagerPage(){
        return "ServicePage";
    }

    @GetMapping("/getAllServices")
    public @ResponseBody List<Service> getAllServices(){
        return serviceService.getAllServices();
    }

    @GetMapping("/getAllSubServices/{pageNumber}")
    public @ResponseBody Page<SubService> getAllSubServices(@PathVariable("pageNumber") int pageNumber){
        Page<SubService> subServices = subServiceService.getAllSubServices(pageNumber);
        return subServices;
    }

    @PostMapping("/addSubService")
    public ResponseEntity addSubService(@RequestBody SubService subService) {
        try {
            subServiceService.addSubService(subService);
            return ResponseEntity.ok("sub service " + subService.getName() + " is added!");
        } catch (Exception exception) {
            return ResponseEntity.status(400).body(exception.getMessage());
        }
    }

    @PostMapping("/addService")
    public ResponseEntity addService(@RequestBody Service service) {
        try {
            serviceService.addService(service);
            return ResponseEntity.ok("service " + service.getName() + " is added!");
        } catch (Exception exception) {
            return ResponseEntity.status(400).body(exception.getMessage());
        }
    }

    @PutMapping("/editService")
    public ResponseEntity editService(@RequestBody Service service) {
        try {
            serviceService.addService(service);
            return ResponseEntity.ok("service " + service.getName() + " is edited!");
        } catch (Exception exception) {
            return ResponseEntity.status(400).body(exception.getMessage());
        }
    }

    @PutMapping("/editSubService")
    public ResponseEntity editSubService(@RequestBody SubService subService) {
        try {
            subServiceService.editSubService(subService);
            return ResponseEntity.ok("subService " + subService.getName() + " is edited!");
        } catch (Exception exception) {
            return ResponseEntity.status(400).body(exception.getMessage());
        }
    }

    @GetMapping("/getServiceById/{id}")
    public @ResponseBody Service getServiceById(@PathVariable("id") int id){
        try {
            return serviceService.getServiceById(id);
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
            return null;
        }
    }

    @DeleteMapping("deleteSubService/{id}")
    public ResponseEntity deleteSubService(@PathVariable("id") int id) {
        try {
            subServiceService.deleteSubServiceById(id);
            return ResponseEntity.ok("subService is deleted!");
        } catch (Exception exception) {
            return ResponseEntity.status(400).body(exception.getMessage());
        }
    }

    @DeleteMapping("deleteService/{id}")
    public ResponseEntity deleteService(@PathVariable("id") int id) {
        try {
            serviceService.deleteServiceById(id);
            return ResponseEntity.ok("Service is deleted!");
        } catch (Exception exception) {
            return ResponseEntity.status(400).body(exception.getMessage());
        }
    }

    @PostMapping("/findByServiceNameAndSubServiceName")
    public @ResponseBody List<SubService> findByServiceNameAndSubServiceName(@RequestBody SubServiceDto subServiceDto){
        return subServiceService.findByServiceNameAndSubServiceName(subServiceDto);
    }

    @PostMapping("/checkServiceFiledLength")
    public ResponseEntity checkServiceFiledLength(@RequestBody InputDto inputDto){
        try {
            serviceService.checkFieldLength(inputDto.getInput(), inputDto.getInputName());
            return ResponseEntity.ok("length looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkServiceNameUniqueness")
    public ResponseEntity checkServiceNameUniqueness(@RequestBody InputDto inputDto){
        try {
            serviceService.checkServiceNameUniqueness(inputDto.getInput());
            return ResponseEntity.ok("name looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkSubServiceFiledLength")
    public ResponseEntity checkSubServiceFiledLength(@RequestBody InputDto inputDto){
        try {
            subServiceService.checkFieldLength(inputDto.getInput(), inputDto.getInputName());
            return ResponseEntity.ok("length looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkSubServicePrice")
    public ResponseEntity checkSubServicePrice(@RequestBody InputDto inputDto){
        try {
            subServiceService.checkPrice(Double.parseDouble(inputDto.getInput()));
            return ResponseEntity.ok("price looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkSubServiceNameUniqueness")
    public ResponseEntity checkSubServiceNameUniqueness(@RequestBody InputDto inputDto){
        try {
            subServiceService.checkSubServiceNameUniqueness(inputDto.getInput());
            return ResponseEntity.ok("name looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkSubServiceEditNameUniqueness/{name}")
    public ResponseEntity checkSubServiceEditNameUniqueness(@RequestBody InputDto inputDto, @PathVariable("name") String name){
        try {
            subServiceService.checkEditSubServiceNameUniqueness(inputDto.getInput(), name);
            return ResponseEntity.ok("name looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

}
