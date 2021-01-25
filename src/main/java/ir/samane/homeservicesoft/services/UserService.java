package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.dto.UserDto;
import ir.samane.homeservicesoft.model.dao.UserDao;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.regex.Pattern;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    UserDao userDao;
    @Autowired
    private PasswordEncoder passwordEncoder;

    private int maxNameLength = 16;
    private int minNameLength = 2;

    public UserService() {

    }

    public User findById(int id) throws Exception {
        User user = userDao.findById(id);
        return user;
    }

    public Boolean findByEmail(String email) {
        Boolean flag = true;
        Optional<User> userByEmail = userDao.findByEmail(email);
        if (userByEmail.isPresent())
            flag = false;
        return flag;
    }

    public Boolean checkPassword(String password) {
        return Pattern.matches("^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z_0-9]{8,}$", password);
    }

    public void checkPasswordFormat(String password) throws Exception {
        if(!checkPassword(password)){
            throw new Exception("Password must contains words and numbers and at least 8 characters");
        }
    }

    public boolean checkNameLength(String name) {
        boolean flag = false;
        if (name.length() <= maxNameLength && name.length() >= minNameLength)
            flag = true;
        return flag;
    }

    public String checkEmailUniqueness(String email) throws Exception {
        boolean emailExistence = findByEmail(email);
        if(!emailExistence){
            throw new Exception("This email is used before");
        }
        return "email is not used before";
    }

    public boolean checkEmail(String email){
        return Pattern.matches("^.+@.+\\..+$", email);
    }

    public void checkEmailFormat(String email) throws Exception {
        if(!checkEmail(email))
            throw new Exception("Email is in incorrect format");
    }

    public void checkUserField(String field, String fieldName) throws Exception {
        checkNullField(field, fieldName);
        if(!checkNameLength(field))
            throw new Exception("User "+fieldName+" length must be between " + minNameLength + " and " +
                    maxNameLength + " characters");
    }

    public void checkNullField(String field, String fieldName) throws Exception {
        if(field == null)
            throw new Exception("User "+fieldName+" can not be null");
    }

    public User registerUser(User user) throws Exception {
        checkUserField(user.getName(), "name");
        checkUserField(user.getFamily(), "family");
        checkNullField(user.getEmail(), "email");
        checkNullField(user.getRole().toString(), "role");
        checkNullField(user.getPassword(), "password");
        checkEmailFormat(user.getEmail());
        checkEmailUniqueness(user.getEmail());
        checkPasswordFormat(user.getPassword());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        User savedUser = userDao.save(user);
        return savedUser;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<User> userByEmail = userDao.findByEmail(email);
        if (!userByEmail.isPresent())
            throw new UsernameNotFoundException("not found");
        User user = userByEmail.get();
        Set<GrantedAuthority> authorities = new HashSet<>();
        authorities.add(new SimpleGrantedAuthority(user.getRole().toString()));
        return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(), authorities);
    }

    public List<Expert> findBy(UserDto userDto) {
        return userDao.findAll(UserDao.findBy(userDto));
    }

}
