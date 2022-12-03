package ir.samane.finowaytask;

import ir.samane.finowaytask.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class CommandLineAppStartupRunner implements CommandLineRunner {
    @Autowired
    private static CustomerService customerService;

    @Override
    public void run(String... args) throws Exception {
//        try {
//            personService.saveAll(personService.readFromFile("/home/samane/Downloads/names.txt"));
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }
}
