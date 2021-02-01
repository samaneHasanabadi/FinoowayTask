package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.OptionDao;
import ir.samane.homeservicesoft.model.entity.Option2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class OptionService {

    private OptionDao optionDao;

    @Autowired
    public void setOptionDao(OptionDao optionDao) {
        this.optionDao = optionDao;
    }

    public void addOption(Option2 option) throws Exception {
        checkStartTime(option.getStartTime());
        checkPositivity(option.getPrice(), "Option price");
        checkPositivity(option.getDuration(), "Option duration");
        Option2 saveOption = optionDao.save(option);

    }

    public void checkStartTime(double startTime) throws Exception {
        if(startTime < 8 || startTime > 20)
            throw new Exception("start time should be between 8 am and 8 pm");
        double remain = (startTime - (int)(startTime));
        if(remain != 0.5 && remain != 0.0)
            throw new Exception("start time should be in sharp time or half");
    }

    public void checkPositivity(double number, String fieldName) throws Exception {
        if(number < 0)
            throw new Exception(fieldName + " should be positive");
    }

    public Option2 findById(int id) throws Exception {
        Optional<Option2> option = optionDao.findById(id);
        if(!option.isPresent())
            throw new Exception("There is no option with this id");
        return option.get();
    }
}
