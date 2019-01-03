package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@Controller
public class RegisterController {

    @Autowired
    private EmployeeService employeeService;


    @PostMapping("/register")
    public String register(@RequestParam("firstname") String firstname, @RequestParam("lastname") String lastname, @RequestParam("email") String email,
       @RequestParam("password") String password, @RequestParam("retype-password") String retypepassword){
        PasswordEncoder bcryptEncoder = new BCryptPasswordEncoder();

        if(!firstname.matches("^[A-Za-z0-9]*$")){
            return "login_minimal";
        }
        if(firstname.length() < 1 || firstname.length() > 45){
            return "login_minimal";
        }
        if(lastname.length() < 1 || lastname.length() > 45){
            return "login_minimal";
        }
        if(!lastname.matches("^[A-Za-z0-9]*$")){
            return "login_minimal";
        }
        if(email.length() < 3 || email.length() > 254){
            return "login_minimal";
        }
        if(password.length() < 8 || password.length() > 72){
            return "login_minimal";
        }
        if(!password.equals(retypepassword)){
            return "login_minimal";
        }
        if(employeeService.findByEmail(email) != null){
            return "login_minimal";
        }

        Employee toAdd = new Employee();
        toAdd.setFirstName(firstname);
        toAdd.setLastName(lastname);

        toAdd.setVarenEmail(email);
        toAdd.setPassword(bcryptEncoder.encode(password));
        toAdd = employeeService.addEmployee(toAdd);

        DefaultUser securityUser = new DefaultUser(toAdd.getId(), toAdd.getVarenEmail(), toAdd.getPassword(),firstname,lastname, new ArrayList<GrantedAuthority>());

        Authentication authentication = new UsernamePasswordAuthenticationToken(securityUser, null, securityUser.getAuthorities());

        SecurityContextHolder.getContext().setAuthentication(authentication);

        return "index";


    }



}
