package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.dto.InputDto;
import ir.samane.homeservicesoft.model.entity.ExpertOptionMap;
import ir.samane.homeservicesoft.model.entity.Option2;
import ir.samane.homeservicesoft.services.ExpertOptionMapService;
import ir.samane.homeservicesoft.services.OptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class OptionController {

    private OptionService optionService;
    private ExpertOptionMapService expertOptionMapService;

    @Autowired
    public void setOptionService(OptionService optionService) {
        this.optionService = optionService;
    }

    @Autowired
    public void setExpertOptionMapService(ExpertOptionMapService expertOptionMapService) {
        this.expertOptionMapService = expertOptionMapService;
    }

    @PostMapping("/checkPositivity")
    public ResponseEntity checkPositivity(@RequestBody InputDto inputDto){
        try {
            optionService.checkPositivity(Double.parseDouble(inputDto.getInput()), inputDto.getInputName());
            return ResponseEntity.ok(inputDto.getInputName() + " looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/checkStartTime")
    public ResponseEntity checkStartTime(@RequestBody InputDto inputDto){
        try {
            optionService.checkStartTime(Double.parseDouble(inputDto.getInput()));
            return ResponseEntity.ok(inputDto.getInputName() + " looks good!");
        }catch (Exception e){
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @GetMapping("/getOptionByExpertAndRequest/{expertId}/{requestId}")
    public @ResponseBody Option2 getOptionByExpertAndRequest(@PathVariable("expertId") int expertId, @PathVariable("requestId") int requestId){
        try {
            return expertOptionMapService.findByExpertIdAndRequestId(expertId,requestId);
        } catch (Exception e) {
            return null;
        }
    }

    @GetMapping("/getOptionsByRequestId/{requestId}")
    public @ResponseBody List<ExpertOptionMap> getOptionsByRequestId(@PathVariable("requestId") int requestId){
        try {
            return expertOptionMapService.getOptionsByRequestId(requestId);
        } catch (Exception e) {
            return null;
        }
    }
}
