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

    public UserService(){

    }

    public User findById(int id) throws Exception {
        User user = userDao.findById(id);
        return user;
    }

    public Boolean findByEmail(String email){
        Boolean flag = true;
        Optional<User> userByEmail = userDao.findByEmail(email);
        if(userByEmail.isPresent())
            flag = false;
        return flag;
    }

    public Boolean passwordCheck(String password){
        return Pattern.matches("[a-zA-Z_0-9!-)]{8,}", password);
    }

    public User registerUser(User user) throws Exception {
        User save = null;
        if(findByEmail(user.getEmail()) && passwordCheck(user.getPassword())) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            save = userDao.save(user);
        }else if(!findByEmail(user.getEmail()))
            throw new Exception("Email is used before");
        else if(!passwordCheck(user.getPassword()))
            throw new Exception("Password is in incorrect format");
        return save;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<User> userByEmail = userDao.findByEmail(email);
        if(!userByEmail.isPresent())
            throw new UsernameNotFoundException("not found");
        User user=userByEmail.get();
        Set<GrantedAuthority> authorities=new HashSet<>();
        authorities.add(new SimpleGrantedAuthority(user.getRole().toString()));
        return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(), authorities);
    }

    public List<Expert> findBy(UserDto userDto){
        return userDao.findAll(UserDao.findBy(userDto));
    }

}
