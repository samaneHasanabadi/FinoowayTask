package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Service;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceDao extends JpaRepository<Service, Integer> {
}
