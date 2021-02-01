package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Option2;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OptionDao extends JpaRepository<Option2, Integer> {
}
