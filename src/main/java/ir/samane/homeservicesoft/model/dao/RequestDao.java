package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.dto.RequestDto;
import ir.samane.homeservicesoft.model.entity.*;
import ir.samane.homeservicesoft.model.enums.RequestStatus;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.*;
import java.util.*;

@Repository
public interface RequestDao extends JpaRepository<Request, Integer>, JpaSpecificationExecutor<Request> {

    @Query("SELECT request FROM Request request WHERE request.subService IN :subServices AND request.expert IS NULL")
    List<Request> getRequestsWithoutExpertBySubServices(@Param("subServices")List<SubService> subServices);

    Optional<Request> findById(int id);

    List<Request> findByRequestStatus(RequestStatus requestStatus);

    @Query("SELECT request FROM Request request WHERE request.requestStatus IN :requestStatuses AND request.expert = :expert")
    List<Request> findByRequestStatusesAndExpert(@Param("requestStatuses")List<RequestStatus> requestStatuses, @Param("expert") Expert expert);

    List<Request> findByRequestStatusAndCustomer(RequestStatus requestStatus, Customer customer);

    default Specification<Request> findBy(RequestStatus requestStatus, Expert expert, Customer customer) {
        return (Specification<Request>) (root, criteriaQuery, criteriaBuilder) -> {
            CriteriaQuery<Request> query = criteriaBuilder.createQuery(Request.class);
            List<Predicate> conditions = new ArrayList<>();
            if (Objects.nonNull(requestStatus)) {
                conditions.add(criteriaBuilder.equal(root.get("requestStatus"), requestStatus));
            }
            if (Objects.nonNull(expert)) {
                conditions.add(criteriaBuilder.equal(root.get("expert"), expert));
            }
            if (Objects.nonNull(customer)) {
                conditions.add(criteriaBuilder.equal(root.get("customer"), customer));
            }
            CriteriaQuery<Request> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

    default Specification<Request> findByDto(RequestDto requestDto) {
        return (Specification<Request>) (root, criteriaQuery, criteriaBuilder) -> {
            CriteriaQuery<Request> query = criteriaBuilder.createQuery(Request.class);
            List<Predicate> conditions = new ArrayList<>();
            if (Objects.nonNull(requestDto.getSubService())) {
                conditions.add(criteriaBuilder.like(root.get("subService").get("name"), "%" + requestDto.getSubService() + "%"));
            }
            if (Objects.nonNull(requestDto.getAddress())) {
                conditions.add(criteriaBuilder.like(root.get("address"), "%" + requestDto.getAddress() + "%"));
            }
            Path<Date> dateCreatedPath = root.get("date");
            if (Objects.nonNull(requestDto.getEndDate())) {
                conditions.add(criteriaBuilder.lessThanOrEqualTo(dateCreatedPath, requestDto.getEndDate()));
            }
            if (Objects.nonNull(requestDto.getStartDate())) {
                conditions.add(criteriaBuilder.greaterThanOrEqualTo(dateCreatedPath, requestDto.getStartDate()));
            }
            conditions.add(criteriaBuilder.ge(root.get("price"), requestDto.getPrice()));
            conditions.add(criteriaBuilder.ge(root.get("proposedPrice"), requestDto.getProposedPrice()));
            if (Objects.nonNull(requestDto.getRequestStatus())) {
                conditions.add(criteriaBuilder.equal(root.get("requestStatus"), requestDto.getRequestStatus()));
            }
            CriteriaQuery<Request> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }
}
