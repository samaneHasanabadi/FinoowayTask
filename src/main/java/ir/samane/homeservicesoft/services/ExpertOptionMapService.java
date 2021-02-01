package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.ExpertOptionMapDao;
import ir.samane.homeservicesoft.model.entity.ExpertOptionMap;
import ir.samane.homeservicesoft.model.entity.Option2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExpertOptionMapService {

    private ExpertOptionMapDao expertOptionMapDao;

    @Autowired
    public void setExpertOptionMapDao(ExpertOptionMapDao expertOptionMapDao) {
        this.expertOptionMapDao = expertOptionMapDao;
    }

    public Option2 findByExpertIdAndRequestId(int expertId, int requestId) throws Exception {
        Optional<Option2> option = expertOptionMapDao.findByExpertIdAndRequestId(expertId, requestId);
        if(!option.isPresent())
            throw new Exception("There is no option for this expert and request");
        return option.get();
    }

    public List<ExpertOptionMap> getOptionsByRequestId(int requestId){
        return expertOptionMapDao.getOptionsByRequestId(requestId);
    }
}
