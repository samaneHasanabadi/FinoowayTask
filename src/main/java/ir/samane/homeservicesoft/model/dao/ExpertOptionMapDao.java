package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.ExpertOptionMap;
import ir.samane.homeservicesoft.model.entity.Option2;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExpertOptionMapDao extends JpaRepository<ExpertOptionMap, Integer> {

    @Query("SELECT expertOptionMap.option FROM ExpertOptionMap expertOptionMap JOIN" +
            " expertOptionMap.request WHERE expertOptionMap.expert.id = :expertId AND" +
            " expertOptionMap.request.id = :requestId")
    Optional<Option2> findByExpertIdAndRequestId(@Param("expertId")int expertId, @Param("requestId")int requestId);

    @Query("SELECT DISTINCT expertOptionMap FROM ExpertOptionMap expertOptionMap JOIN" +
            " expertOptionMap.request WHERE expertOptionMap.request.id = :requestId")
    List<ExpertOptionMap> getOptionsByRequestId(@Param("requestId")int requestId);

}
