package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.SubService;
import ir.samane.homeservicesoft.model.enums.RegisterStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExpertDao extends JpaRepository<Expert, Integer> {

    List<Expert> findByStatus(RegisterStatus registerStatus);

    @Query("select expert from Expert expert WHERE :subService member of expert.subServices")
    List<Expert> findBySubService(@Param("subService")SubService subService);


}
