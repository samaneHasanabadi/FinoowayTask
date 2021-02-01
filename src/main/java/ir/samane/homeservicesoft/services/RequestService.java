package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.RequestDao;
import ir.samane.homeservicesoft.model.entity.*;
import ir.samane.homeservicesoft.model.enums.RequestStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class RequestService {

    private RequestDao requestDao;
    private OptionService optionService;
    private int maxLength = 16;

    @Autowired
    public void setRequestDao(RequestDao requestDao) {
        this.requestDao = requestDao;
    }

    @Autowired
    public void setOptionService(OptionService optionService) {
        this.optionService = optionService;
    }

    public void addRequest(Request request) throws Exception {
        checkNullAllFields(request);
        checkTitleLength(request.getTitle());
        checkProposedPrice(request.getProposedPrice(), request.getSubService().getPrice());
        checkDate(request.getDate());
        setRequestStatus(request);
        request.setRequestStatus(RequestStatus.WAITING_FOR_EXPERTS_OPTIONS);
        requestDao.save(request);
    }

    public void checkTitleLength(String title) throws Exception {
        if(title.length() > maxLength)
            throw new Exception("Title length must be less than " + maxLength);
    }

    public void setRequestStatus(Request request){
        if(request.getId() != 0)
            request.setRequestStatus(RequestStatus.WAITING_FOR_EXPERTS_OPTIONS);
    }

    public void checkNullAllFields(Request request) throws Exception {
        checkNullField(request.getTitle(), "title");
        checkNullField(request.getCustomer() , "Request customer");
        checkNullField(request.getSubService(), "Request sub service");
        checkNullField(request.getDate(), "Request date");
        checkNullField(request.getAddress(), "Request address");
        checkNullField(request.getDescription(), "Request description");
    }

    public <T> void checkNullField(T t, String fieldName) throws Exception {
        if( t == null)
            throw new Exception(fieldName + " can not be null");
    }

    public void checkProposedPrice(double price, double subServicePrice) throws Exception {
        if(price < 0)
            throw new Exception("price must be positive");
        if(price < subServicePrice)
            throw new Exception("price should be bigger than sub service price");
    }

    public void checkDate(Date date) throws Exception {
        Date currentDate = new Date();
        if(date.before(currentDate))
            throw new Exception("Date can not be in the past");
    }

    public List<Request> getRequestsWithoutExpertOfSubServices(List<SubService> subServices) throws Exception {
        checkNullField(subServices, "list Of Sub Services");
        return requestDao.getRequestsWithoutExpertBySubServices(subServices).stream()
                .filter(request -> request.getDate().after(new Date()))
                .collect(Collectors.toList());
    }

    public List<Request> getRequestsWaitingForChoosingExpert(){
        return requestDao.findByRequestStatus(RequestStatus.WAITING_FOR_CHOOSING_EXPERT).stream()
                .filter(request -> request.getDate().after(new Date()))
                .collect(Collectors.toList());
    }

    public void setRequestExpertOption(int requestId, Expert expert, Option2 option) throws Exception {
        checkNullField(expert, "expert");
        checkNullField(option, "option");
        Request request = findById(requestId);
        checkOptionPrice(option.getPrice(), request.getSubService().getPrice());
        if(option.getId() > 0){
            optionService.addOption(option);
        }
        else {
            optionService.addOption(option);
            ExpertOptionMap expertOptionMap = getExpertOptionMap(expert, option);
            expertOptionMap.setRequest(request);
            addExpertOption(request, expertOptionMap);
            request.setRequestStatus(RequestStatus.WAITING_FOR_CHOOSING_EXPERT);
            requestDao.save(request);
        }
    }

    private void addExpertOption(Request request, ExpertOptionMap expertOptionMap) {
        request.getExpertsOption().add(expertOptionMap);
    }

    private ExpertOptionMap getExpertOptionMap(Expert expert, Option2 option) {
        ExpertOptionMap expertOptionMap = new ExpertOptionMap();
        expertOptionMap.setExpert(expert);
        expertOptionMap.setOption(option);
        return expertOptionMap;
    }

    public void checkOptionPrice(double optionPrice, double subServicePrice) throws Exception {
        if(optionPrice < subServicePrice)
            throw new Exception("Option price should be greater or equal to" +
                    " related sub service price");
    }

    public Request findById(int id) throws Exception {
        Optional<Request> request = requestDao.findById(id);
        if(!request.isPresent())
            throw new Exception("There is no request with this id");
        return request.get();
    }

    public void setExpertOfRequest(int requestId, Expert expert) throws Exception {
        Request request = findById(requestId);
        checkNullField(expert, "expert");
        checkExpertExistInRequestExpertOption(request, expert);
        request.setExpert(expert);
        request.setRequestStatus(RequestStatus.WAITING_FOR_COMING_EXPERT);
        setRequestPrice(expert, request);
        requestDao.save(request);
    }

    private void setRequestPrice(Expert expert, Request request) {
        request.setPrice(request.getExpertsOption().stream().filter(expertOption -> expertOption.getExpert().equals(expert)).collect(Collectors.toList()).get(0).getOption().getPrice());
    }

    public void checkExpertExistInRequestExpertOption(Request request, Expert expert) throws Exception {
        if(request.getExpertsOption().stream().filter(expertOption ->
                expertOption.getExpert().equals(expert)).collect(Collectors.toList())
                .size() == 0)
            throw new Exception("Expert " + expert.getName() + " " + expert.getFamily() +
                    " does not exists in request experts options");
    }

    public List<Request> getApprovedRequestsOfExpert(Expert expert) throws Exception {
        checkNullField(expert, "expert");
        List<RequestStatus> requestStatuses = new ArrayList<>();
        requestStatuses.add(RequestStatus.WAITING_FOR_COMING_EXPERT);
        requestStatuses.add(RequestStatus.IN_PROCESS);
        requestStatuses.add(RequestStatus.FINISHED);
        return requestDao.findByRequestStatusAndExpert(requestStatuses, expert);
    }

    public void startRequest(int requestId) throws Exception {
        Request request = findById(requestId);
        request.setRequestStatus(RequestStatus.IN_PROCESS);
        requestDao.save(request);
    }

    public void finishRequest(int requestId) throws Exception {
        Request request = findById(requestId);
        request.setRequestStatus(RequestStatus.FINISHED);
        requestDao.save(request);
    }

}
