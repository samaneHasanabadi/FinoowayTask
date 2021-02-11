package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.Request;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.model.entity.User;
import ir.samane.homeservicesoft.model.enums.RegisterStatus;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Repository
public interface ExpertDao extends JpaRepository<Expert, Integer>, JpaSpecificationExecutor<User> {

    List<Expert> findByStatus(RegisterStatus registerStatus);

    @Query("select expert from Expert expert WHERE :subService member of expert.subServices")
    List<Expert> findBySubService(@Param("subService")SubService subService);

    static Specification<User> findByCreationDateAndRequests(Date start, Date end) {
        return (Specification<User>) (root, criteriaQuery, criteriaBuilder) -> {
            CriteriaQuery<User> query = criteriaBuilder.createQuery(User.class);
            List<Predicate> conditions = new ArrayList<>();
            Path<Date> dateCreatedPath = root.get("creationDate");
            if (Objects.nonNull(end)) {
                conditions.add(criteriaBuilder.lessThanOrEqualTo(dateCreatedPath, end));
            }
            if (Objects.nonNull(start)) {
                conditions.add(criteriaBuilder.greaterThanOrEqualTo(dateCreatedPath, start));
            }
            root.get("requests");
//            root.fetch("requests", JoinType.L);
//            Join<User, Request> jn = root.join("requests", JoinType.INNER);
//            conditions.add(criteriaBuilder.like(jn.get("title"), "%" + "%"));
            CriteriaQuery<User> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

}
