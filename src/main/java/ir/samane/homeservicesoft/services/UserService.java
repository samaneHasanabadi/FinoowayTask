package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.dto.UserDto;
import ir.samane.homeservicesoft.model.dao.ExpertDao;
import ir.samane.homeservicesoft.model.dao.UserDao;
import ir.samane.homeservicesoft.model.entity.ConfirmationToken;
import ir.samane.homeservicesoft.model.entity.Expert;
import ir.samane.homeservicesoft.model.entity.User;
import ir.samane.homeservicesoft.model.enums.RegisterStatus;
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

    private UserDao userDao;
    private PasswordEncoder passwordEncoder;
    private ConfirmationTokenService confirmationTokenService;
    private ExpertService expertService;

    private int maxNameLength = 16;
    private int minNameLength = 2;

    public UserService() {

    }

    @Autowired
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Autowired
    public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Autowired
    public void setConfirmationTokenService(ConfirmationTokenService confirmationTokenService) {
        this.confirmationTokenService = confirmationTokenService;
    }

    @Autowired
    public void setExpertService(ExpertService expertService) {
        this.expertService = expertService;
    }

    public User findById(int id) throws Exception {
        Optional<User> user = userDao.findById(id);
        if(!user.isPresent())
            throw new Exception("There is no User with this Id");
        return user.get();
    }

    public Boolean findByEmail(String email) {
        Boolean flag = true;
        Optional<User> userByEmail = userDao.findByEmail(email);
        if (userByEmail.isPresent())
            flag = false;
        return flag;
    }

    public User getUserByEmail(String email) throws Exception {
        Optional<User> userByEmail = userDao.findByEmail(email);
        if (!userByEmail.isPresent())
            throw new Exception("There is no user with this email!");
        return userByEmail.get();
    }

    public void checkEditEmailUniqueness(String editEmail, String email) throws Exception {
        if(!editEmail.equals(email) && !findByEmail(editEmail))
            throw new Exception("Email is used before");
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
        if(!userByEmail.get().getStatus().equals(RegisterStatus.APPROVED))
            throw new UsernameNotFoundException("User Must be in Approved Status");
        User user = userByEmail.get();
        Set<GrantedAuthority> authorities = new HashSet<>();
        authorities.add(new SimpleGrantedAuthority(user.getRole().toString()));
        return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(), authorities);
    }

    public List<Expert> findBy(UserDto userDto) {
        return userDao.findAll(UserDao.findBy(userDto));
    }

    public void editUser(Expert user, String email) throws Exception {
        checkNullField(user.getName(), "name");
        checkNullField(user.getFamily(), "family");
        checkNullField(user.getEmail(), "email");
        checkEmailFormat(user.getEmail());
        checkEditEmailUniqueness(user.getEmail(), email);
        Expert expert = expertService.findById(user.getId());
        expert.setName(user.getName());
        expert.setFamily(user.getFamily());
        expert.setEmail(user.getEmail());
        expertService.saveExpert(expert);
    }

    public void deleteById(int id) throws Exception {
        Optional<ConfirmationToken> confirmationToken = confirmationTokenService.findByUser(findById(id));
        if(confirmationToken.isPresent())
            confirmationTokenService.deleteConfirmationToken(confirmationToken.get().getId());
        userDao.deleteById(id);
    }

}
