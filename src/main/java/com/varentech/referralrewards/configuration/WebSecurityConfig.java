package com.varentech.referralrewards.configuration;

import com.varentech.referralrewards.security.DefaultAuthenticationSuccessHandler;
import com.varentech.referralrewards.security.DefaultUserDetailsContextMapper;
import com.varentech.referralrewards.security.DefaultUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.ldap.authentication.ad.ActiveDirectoryLdapAuthenticationProvider;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


    @Autowired
    private DefaultUserDetailsService userDetailsService;

    @Autowired
    private DefaultAuthenticationSuccessHandler defaultAuthenticationSuccessHandler;

    @Autowired
    private DefaultUserDetailsContextMapper defaultUserDetailsContextMapper;

    @Value("${authentication.mode}")
    private String authenticationMode;

    @Value("${https}")
    private String https;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/resources/**", "/register", "/test", "/user/*/available","/emailtest").permitAll().antMatchers("/admin").hasAnyAuthority("admin","superadmin").antMatchers("/deleteupdates").hasAnyAuthority("recruiter", "admin","superadmin").antMatchers("/recoverupdates").hasAnyAuthority("admin","superadmin")
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .successHandler(defaultAuthenticationSuccessHandler)
                .loginPage("/login").failureForwardUrl("/loginerror")
                .permitAll()
                .and()
                .logout()
                .permitAll().and();

        if(https.equalsIgnoreCase("true")) {

                    http.requiresChannel()
                    .anyRequest().requiresSecure();
        }
    }

/*
    public UserDetailsService userDetailsService(){
        return userDetailsService;
    }*/




    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        if(authenticationMode.equals("active_directory")) {
            ActiveDirectoryLdapAuthenticationProvider adProvider = new ActiveDirectoryLdapAuthenticationProvider("varentech.com", "ldap://10.10.20.4:389");
            adProvider.setConvertSubErrorCodesToExceptions(true);
            adProvider.setUseAuthenticationRequestCredentials(true);
            adProvider.setSearchFilter("(&(objectClass=user)(userPrincipalName={0}))");
            adProvider.setUserDetailsContextMapper(defaultUserDetailsContextMapper);
            auth.authenticationProvider(adProvider);
            auth.eraseCredentials(false);
            }
        else if(authenticationMode.equals("default")){
            auth.userDetailsService(userDetailsService);
        }
        else{
            throw new IllegalArgumentException("Unrecognized authentication.mode value in application.properties");
        }

    }


}
