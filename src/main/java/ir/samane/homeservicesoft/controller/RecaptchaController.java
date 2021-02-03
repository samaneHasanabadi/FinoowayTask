package ir.samane.homeservicesoft.controller;

import ir.samane.homeservicesoft.captcha.ReCaptchaResponse;
import ir.samane.homeservicesoft.dto.InputDto;
import ir.samane.homeservicesoft.facade.RequestFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RecaptchaController {

    //@Value("google.recaptcha.key.secret")
    private String recaptchaSecret = "6LeLBUgaAAAAAGP81kjIV4zBGF0o1gqXSv-3fx4x";

    //@Value("recaptcha.url")
    private String recaptchaServerUrl = "https://www.google.com/recaptcha/api/siteverify";

    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder){
        return builder.build();
    }

    private RestTemplate restTemplate;
    private RequestFacade requestFacade;

    @Autowired
    public void setRestTemplate(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @Autowired
    public void setRequestFacade(RequestFacade requestFacade) {
        this.requestFacade = requestFacade;
    }

    @PostMapping("/onlinePayment/{requestId}")
    public ResponseEntity onlinePayment(@RequestBody InputDto inputDto, @PathVariable("requestId") int requestId){
        String gRecaptchaResponse = inputDto.getInput();
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("secret", recaptchaSecret);
        map.add("response", gRecaptchaResponse);
        HttpEntity<MultiValueMap<String, String>> request2 = new HttpEntity<>(map, httpHeaders);
        System.out.println(recaptchaServerUrl);
        ReCaptchaResponse reCaptchaResponse = restTemplate.postForObject(recaptchaServerUrl, request2, ReCaptchaResponse.class);
        if(reCaptchaResponse.isSuccess()){
            try {
                requestFacade.payExpertSalaryOfRequest(requestId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return ResponseEntity.ok("Your payment is done successfully");
        }else {
            return ResponseEntity.ok("some errors : " + reCaptchaResponse.getErrorCodes()[0]);
        }
    }
}
