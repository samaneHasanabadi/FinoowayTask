package ir.samane.finowaytask.model.dao;

import ir.samane.finowaytask.model.entity.Customer;
import ir.samane.finowaytask.model.entity.Wallet;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Repository
public interface CustomerDao extends JpaRepository<Customer, Integer>, JpaSpecificationExecutor<Customer> {

    @Query("SELECT customer FROM Customer  customer WHERE customer.wallet.id = :walletId")
    Optional<Customer> findByWalletId(@Param("walletId") Integer walletId);

    default Specification<Customer> findBy(Customer customer) {
        return (Specification<Customer>) (root, criteriaQuery, criteriaBuilder) -> {
            CriteriaQuery<Customer> query = criteriaBuilder.createQuery(Customer.class);
            List<Predicate> conditions = new ArrayList<>();
            if (Objects.nonNull(customer)) {
                if (StringUtils.hasText(customer.getName())) {
                    conditions.add(criteriaBuilder.like(root.get(Customer.NAME), "%" + customer.getName() + "%"));
                }
                if (Objects.nonNull(customer.getId())) {
                    conditions.add(criteriaBuilder.equal(root.get(Customer.ID), customer.getId()));
                }
            }
            CriteriaQuery<Customer> expertCriteriaQuery = query.select(root)
                    .where(conditions.toArray(new Predicate[]{}));
            return expertCriteriaQuery.getRestriction();
        };
    }

}
