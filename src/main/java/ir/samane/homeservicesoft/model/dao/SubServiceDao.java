package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.Service;
import ir.samane.homeservicesoft.model.entity.SubService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Repository
public interface SubServiceDao extends JpaRepository<SubService, Integer>, JpaSpecificationExecutor<SubService> {

    @Query("select subService from SubService subService WHERE :expert member of subService.experts")
    List<SubService> findByExpert(@Param("expert")Expert expert);

    List<SubService> findByService(Service service);

    Optional<SubService> findByName(String name);

    static Specification<SubService> findBy(String serviceName, String subServiceName) {
        return (Specification<SubService>) (root, criteriaQuery, criteriaBuilder) -> {
            CriteriaQuery<SubService> query = criteriaBuilder.createQuery(SubService.class);
            List<Predicate> conditions = new ArrayList<>();
            if (Objects.nonNull(serviceName)) {
                Join<SubService, Service> subServiceServiceJoin = root.join("service", JoinType.INNER);
                conditions.add(criteriaBuilder.like(subServiceServiceJoin.get("name"), "%" + serviceName + "%"));
            }
            if (Objects.nonNull(subServiceName)) {
                conditions.add(criteriaBuilder.like(root.get("name"), "%" + subServiceName + "%"));
            }
            CriteriaQuery<SubService> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

}
