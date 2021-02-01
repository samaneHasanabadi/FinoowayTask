package ir.samane.homeservicesoft.facade;

import ir.samane.homeservicesoft.model.entity.*;
import ir.samane.homeservicesoft.services.CustomerService;
import ir.samane.homeservicesoft.services.ExpertService;
import ir.samane.homeservicesoft.services.RequestService;
import ir.samane.homeservicesoft.services.SubServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RequestFacade {

    private RequestService requestService;
    private CustomerService customerService;
    private SubServiceService subServiceService;
    private ExpertService expertService;

    @Autowired
    public void setRequestService(RequestService requestService) {
        this.requestService = requestService;
    }

    @Autowired
    public void setCustomerService(CustomerService customerService) {
        this.customerService = customerService;
    }

    @Autowired
    public void setSubServiceService(SubServiceService subServiceService) {
        this.subServiceService = subServiceService;
    }

    @Autowired
    public void setExpertService(ExpertService expertService) {
        this.expertService = expertService;
    }

    public void addRequest(Request request, int customerId, int subServiceId) throws Exception {
        SubService subService = subServiceService.findById(subServiceId);
        Customer customer = customerService.findById(customerId);
        request.setCustomer(customer);
        request.setSubService(subService);
        requestService.addRequest(request);
    }

    public List<Request> getRequestsWithoutExpertOfExpertSubServices(int expertId) throws Exception {
        Expert expert = expertService.findById(expertId);
        return requestService.getRequestsWithoutExpertOfSubServices(expert.getSubServices());
    }

    public void checkOptionPrice(int requestId, double optionPrice) throws Exception {
        Request request = requestService.findById(requestId);
        requestService.checkOptionPrice(optionPrice, request.getSubService().getPrice());
    }

    public void setRequestExpertOption(int requestId, int expertId, Option2 option) throws Exception {
        Expert expert = expertService.findById(expertId);
        requestService.setRequestExpertOption(requestId, expert, option);
    }

    public void setExpertOfRequest(int requestId, int expertId) throws Exception {
        Expert expert = expertService.findById(expertId);
        requestService.setExpertOfRequest(requestId, expert);
    }

    public List<Request> getApprovedRequestsOfExpert(int expertId) throws Exception {
        Expert expert = expertService.findById(expertId);
        return requestService.getApprovedRequestsOfExpert(expert);
    }

}
