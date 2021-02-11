package ir.samane.homeservicesoft.dto;

import ir.samane.homeservicesoft.model.entity.User;

public class SearchRequestDto {
    private User user;
    private int numberOfRequests;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getNumberOfRequests() {
        return numberOfRequests;
    }

    public void setNumberOfRequests(int numberOfRequests) {
        this.numberOfRequests = numberOfRequests;
    }
}
