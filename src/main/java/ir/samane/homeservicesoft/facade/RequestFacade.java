package ir.samane.homeservicesoft.facade;

import ir.samane.homeservicesoft.model.entity.*;
import ir.samane.homeservicesoft.model.enums.RequestStatus;
import ir.samane.homeservicesoft.services.*;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RequestFacade {

    private RequestService requestService;
    private CustomerService customerService;
    private SubServiceService subServiceService;
    private ExpertService expertService;
    private CommentService commentService;
    private double percentOfSalary = 0.7;

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

    @Autowired
    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
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

    public List<Request> getFinishedRequestsOfCustomer(int customerId) throws Exception {
        Customer customer = customerService.findById(customerId);
        return requestService.getFinishedRequestsOfCustomer(customer);
    }

    public void payExpertSalaryOfRequest(int requestId) throws Exception {
        Request request = requestService.findById(requestId);
        double salary = request.getPrice() * percentOfSalary;
        expertService.changeCreditOfExpert(request.getExpert(), salary);
        expertService.saveExpert(request.getExpert());
        request.setRequestStatus(RequestStatus.PAID);
        requestService.save(request);
    }

    public void addCommentToRequest(int requestId, Comment comment) throws Exception {
        Request request = requestService.findById(requestId);
        commentService.addComment(comment);
        request.setComment(comment);
        request.getExpert().setCredit(request.getExpert().getCredit() + comment.getScore());
        expertService.saveExpert(request.getExpert());
        //request.setRequestStatus(RequestStatus.COMMENTED);
        requestService.save(request);
    }

    public List<Request> getPaidRequestsOfCustomer(int customerId) throws Exception {
        Customer customer = customerService.findById(customerId);
        return requestService.getPaidRequestsOfCustomer(customer);
    }

    public Comment getCommentByRequestId(int requestId) throws Exception {
        Request request = requestService.findById(requestId);
        return request.getComment();

    }

    public List<Request> getCustomerRequestsByStatus(RequestStatus requestStatus, int customerId) throws Exception {
        Customer customer = customerService.findById(customerId);
        return requestService.getCustomerRequestsByStatus(requestStatus, customer);
    }

    public List<Request> getExpertRequestsByStatus(RequestStatus requestStatus, int expertId) throws Exception {
        Expert expert = expertService.findById(expertId);
        return requestService.getExpertRequestsByStatus(requestStatus, expert);
    }

}
