package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Customer;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.Request;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.model.enums.RequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RequestDao extends JpaRepository<Request, Integer> {

    @Query("SELECT request FROM Request request WHERE request.subService IN :subServices AND request.expert IS NULL")
    List<Request> getRequestsWithoutExpertBySubServices(@Param("subServices")List<SubService> subServices);

    Optional<Request> findById(int id);

    List<Request> findByRequestStatus(RequestStatus requestStatus);

    @Query("SELECT request FROM Request request WHERE request.requestStatus IN :requestStatuses AND request.expert = :expert")
    List<Request> findByRequestStatusAndExpert(@Param("requestStatuses")List<RequestStatus> requestStatuses,@Param("expert") Expert expert);

    List<Request> findByRequestStatusAndCustomer(RequestStatus requestStatus, Customer customer);
}
