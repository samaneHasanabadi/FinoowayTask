package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Service;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ServiceDao extends JpaRepository<Service, Integer> {

    Optional<Service> findByName(String name);
}
