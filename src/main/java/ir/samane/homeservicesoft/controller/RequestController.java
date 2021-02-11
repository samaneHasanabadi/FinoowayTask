package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.dto.InputDto;
import ir.samane.homeservicesoft.dto.RequestDto;
import ir.samane.homeservicesoft.facade.RequestFacade;
import ir.samane.homeservicesoft.model.entity.Comment;
import ir.samane.homeservicesoft.model.entity.Option2;
import ir.samane.homeservicesoft.model.entity.Request;
import ir.samane.homeservicesoft.model.enums.RequestStatus;
import ir.samane.homeservicesoft.services.RequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class RequestController {
    private RequestService requestService;
    private RequestFacade requestFacade;

    @Autowired
    public void setRequestService(RequestService requestService) {
        this.requestService = requestService;
    }

    @Autowired
    public void setRequestFacade(RequestFacade requestFacade) {
        this.requestFacade = requestFacade;
    }

    @PostMapping("/checkTitleLength")
    public ResponseEntity checkTitleLength(@RequestBody InputDto inputDto) {
        try {
            requestService.checkTitleLength(inputDto.getInput());
            return ResponseEntity.ok("name looks good!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkDate")
    public ResponseEntity checkDate(@RequestBody Request request) {
        try {
            requestService.checkDate(request.getDate());
            return ResponseEntity.ok("name looks good!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkPrice")
    public ResponseEntity checkPrice(@RequestBody InputDto inputDto) {
        try {
            requestService.checkProposedPrice(Double.parseDouble(inputDto.getInput()), Double.parseDouble(inputDto.getInputName()));
            return ResponseEntity.ok("name looks good!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkOptionPrice/{requestId}")
    public ResponseEntity checkOptionPrice(@RequestBody InputDto inputDto, @PathVariable("requestId") int requestId) {
        try {
            requestFacade.checkOptionPrice(requestId, Double.parseDouble(inputDto.getInput()));
            return ResponseEntity.ok("name looks good!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/addRequest/{customerId}/{subServiceId}")
    public ResponseEntity addRequest(@RequestBody Request request, @PathVariable("customerId") int customerId, @PathVariable("subServiceId") int subServiceId) {
        try {
            requestFacade.addRequest(request, customerId, subServiceId);
            return ResponseEntity.ok("Request is added successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @GetMapping("/getRequestsWithoutExpert/{expertId}")
    public @ResponseBody List<Request> getRequestsWithOutExpertByExpertId(@PathVariable("expertId") int expertId) {
        try {
            return requestFacade.getRequestsWithoutExpertOfExpertSubServices(expertId);
        } catch (Exception e) {
            return null;
        }
    }

    @GetMapping("/getApprovedRequestsOfExpert/{expertId}")
    public @ResponseBody List<Request> getApprovedRequestsOfExpert(@PathVariable("expertId") int expertId) {
        try {
            return requestFacade.getApprovedRequestsOfExpert(expertId);
        } catch (Exception e) {
            return null;
        }
    }

    @PostMapping("/addOption/{requestId}/{expertId}")
    public ResponseEntity setRequestExpertOption(@PathVariable("requestId") int requestId, @PathVariable("expertId") int expertId, @RequestBody Option2 option) {
        try {
            requestFacade.setRequestExpertOption(requestId, expertId, option);
            return ResponseEntity.ok("Option is saved successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @GetMapping("/getRequestsWaitingForChoosingExpert")
    public @ResponseBody List<Request> getRequestsWaitingForChoosingExpert() {
        try {
            return requestService.getRequestsWaitingForChoosingExpert();
        } catch (Exception e) {
            return null;
        }
    }

    @PutMapping("/addExpertToRequest/{requestId}/{expertId}")
    public ResponseEntity addExpertToRequest(@PathVariable("requestId") int requestId, @PathVariable("expertId") int expertId) {
        try {
            requestFacade.setExpertOfRequest(requestId, expertId);
            return ResponseEntity.ok("Expert is added to request successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PutMapping("/startRequest/{requestId}")
    public ResponseEntity startRequest(@PathVariable("requestId") int requestId) {
        try {
            requestService.startRequest(requestId);
            return ResponseEntity.ok("Service is started!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PutMapping("/finishRequest/{requestId}")
    public ResponseEntity finishRequest(@PathVariable("requestId") int requestId) {
        try {
            requestService.finishRequest(requestId);
            return ResponseEntity.ok("Service is finished!");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @GetMapping("/getFinishedRequestsOfCustomer/{customerId}")
    public @ResponseBody List<Request> getFinishedRequestsOfCustomer(@PathVariable("customerId") int customerId){
        try {
            return requestFacade.getFinishedRequestsOfCustomer(customerId);
        } catch (Exception e) {
            return null;
        }
    }

    @GetMapping("/getPaidRequestsOfCustomer/{customerId}")
    public @ResponseBody List<Request> getPaidRequestsOfCustomer(@PathVariable("customerId") int customerId){
        try {
            return requestFacade.getPaidRequestsOfCustomer(customerId);
        } catch (Exception e) {
            return null;
        }
    }

    @GetMapping("/getCommentByRequestId/{requestId}")
    public @ResponseBody Comment getCommentByRequestId(@PathVariable("requestId") int requestId){
        try {
            return requestFacade.getCommentByRequestId(requestId);
        } catch (Exception e) {
            return null;
        }
    }

    @PostMapping("/addCommentToRequest/{requestId}")
    public ResponseEntity addCommentToRequest(@PathVariable("requestId") int requestId, @RequestBody Comment comment){
        try {
            requestFacade.addCommentToRequest(requestId, comment);
            return ResponseEntity.ok("Comment is added to request successfully");
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @GetMapping("/getCustomerRequests/{customerId}/{status}")
    public @ResponseBody List<Request> getCustomerRequests(@PathVariable("customerId") int customerId, @PathVariable("status") String status){
        try {
            RequestStatus requestStatus = null;
            if(!status.equals("null"))
                requestStatus = RequestStatus.valueOf(status);
            return requestFacade.getCustomerRequestsByStatus(requestStatus, customerId);
        } catch (Exception e) {
            return null;
        }
    }

    @GetMapping("/getExpertRequests/{expertId}/{status}")
    public @ResponseBody List<Request> getExpertRequests(@PathVariable("expertId") int expertId, @PathVariable("status") String status){
        try {
            RequestStatus requestStatus = null;
            if(!status.equals("null"))
                requestStatus = RequestStatus.valueOf(status);
            return requestFacade.getExpertRequestsByStatus(requestStatus, expertId);
        } catch (Exception e) {
            return null;
        }
    }

    @PostMapping("/findByCriteriaRequests")
    public @ResponseBody List<Request> findByCriteriaRequests(@RequestBody RequestDto requestDto){
        return requestService.findByCriteria(requestDto);
    }
}
