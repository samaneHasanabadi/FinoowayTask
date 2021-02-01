package ir.samane.homeservicesoft.config;

import ir.samane.homeservicesoft.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.OrRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import java.util.ArrayList;
import java.util.List;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        List<RequestMatcher> requestMatchers = new ArrayList<RequestMatcher>();
        // allow /api/public/product/** and /api/public/content/** not intercepted by Spring OAuth2
        requestMatchers.add(new AntPathRequestMatcher("/home"));
        requestMatchers.add(new AntPathRequestMatcher("/signup"));
        //csrf attacks kari nadarim
        http.csrf().disable()
//                .requestMatcher(new OrRequestMatcher(requestMatchers))
                .authorizeRequests()
//                .antMatchers("/").permitAll()
//                .antMatchers(HttpMethod.POST, "/").permitAll()
//                .antMatchers(HttpMethod.GET, "/").permitAll()
////                .antMatchers(HttpMethod.POST, "/addUser/*").permitAll()
//                .and().httpBasic();
                .antMatchers("/home","/signup").permitAll()
                .antMatchers(HttpMethod.GET, "/c.png","/d.png").permitAll()
                .antMatchers(HttpMethod.POST, "/addUser/*").permitAll()
                .antMatchers(HttpMethod.POST, "/passwordCheck").permitAll()
                .antMatchers(HttpMethod.POST, "/nameCheck").permitAll()
                .antMatchers(HttpMethod.POST, "/emailCheck").permitAll()
                .antMatchers(HttpMethod.POST, "/emailCheckUniqueness").permitAll()
                .antMatchers(HttpMethod.POST, "/uploadFile").permitAll()
                .antMatchers(HttpMethod.POST, "/uploadFile").permitAll()
                .antMatchers("/Manager/*").hasAuthority("MANAGER")
                .antMatchers("/Expert/*").hasAuthority("EXPERT")
                .antMatchers("/Customer/*").hasAuthority("CUSTOMER")
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/loginProcess")
                .usernameParameter("email")
                .passwordParameter("password")
                .successHandler(myAuthenticationSuccessHandler())
                .failureForwardUrl("/loginError")
                .permitAll()
                .and()
                .logout()
                .permitAll()
                .and()
                .httpBasic();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
    }

    @Bean
    public AuthenticationSuccessHandler myAuthenticationSuccessHandler(){
        return new MySimpleUrlAuthenticationSuccessHandler();
    }
}