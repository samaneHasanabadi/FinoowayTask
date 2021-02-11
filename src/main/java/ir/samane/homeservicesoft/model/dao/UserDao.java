package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.dto.SearchRequestDto;
import ir.samane.homeservicesoft.dto.UserDto;
import ir.samane.homeservicesoft.model.entity.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.*;
import java.util.*;

@Repository
public interface UserDao extends JpaRepository<User, Integer> , JpaSpecificationExecutor<Expert> {

    Optional<User> findByEmail(String email);

    Optional<User> findById(int id);

    static Specification<Expert> findBy(UserDto userDto) {
        return (Specification<Expert>) (root, criteriaQuery, criteriaBuilder) -> {
            CriteriaQuery<User> query = criteriaBuilder.createQuery(User.class);
            List<Predicate> conditions = new ArrayList<>();
            if (Objects.nonNull(userDto.getName())) {
                conditions.add(criteriaBuilder.like(root.get("name"), "%" + userDto.getName() + "%"));
            }
            if (Objects.nonNull(userDto.getFamily())) {
                conditions.add(criteriaBuilder.like(root.get("family"), "%" + userDto.getFamily() + "%"));
            }
            if (Objects.nonNull(userDto.getEmail())) {
                conditions.add(criteriaBuilder.like(root.get("email"), "%" + userDto.getEmail() + "%"));
            }
            if (Objects.nonNull(userDto.getRole())) {
                conditions.add(criteriaBuilder.equal(root.get("role"),  userDto.getRole()));
            }
            if (Objects.nonNull(userDto.getStatus())) {
                conditions.add(criteriaBuilder.equal(root.get("status"), userDto.getStatus()));
            }
            if (userDto.getScore()>0) {
                Root<Expert> rootFullTImeEmployee = criteriaBuilder.treat(root, Expert.class);
                conditions.add(criteriaBuilder.ge(rootFullTImeEmployee.get("score"), userDto.getScore()));
            }
            if(!userDto.getService().equals("")) {
                Root<Expert> rootFullTImeEmployee = criteriaBuilder.treat(root, Expert.class);
                Join<Expert, SubService> subServiceServiceJoin = rootFullTImeEmployee.join("subServices", JoinType.INNER);
                Join<SubService, Service> serviceJoin = subServiceServiceJoin.join("service", JoinType.INNER);
                conditions.add(criteriaBuilder.like(serviceJoin.get("name"), "%" + userDto.getService() + "%"));
            }
            if(!userDto.getSubService().equals("")) {
                Root<Expert> rootFullTImeEmployee = criteriaBuilder.treat(root, Expert.class);
                Join<Expert, SubService> subServiceServiceJoin = rootFullTImeEmployee.join("subServices", JoinType.INNER);
                conditions.add(criteriaBuilder.like(subServiceServiceJoin.get("name"), "%" + userDto.getSubService() + "%"));
            }
            CriteriaQuery<User> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

}
