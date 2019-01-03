package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;

@RestController
public class RegistrationRestController {


    @Autowired
    private EmployeeService employeeService;


    @GetMapping(value = "/user/username/available", produces = "application/json; charset=UTF-8")
    public Map<String,Boolean> usernameAvailable(@RequestParam("q") String username){
        if (!username.matches("^[A-Za-z0-9]*$") || username.length() < 4 || username.length() > 25) { //If username is not alphanumeric, then it violates database rules and cannot exist. So returns false
            return Collections.<String, Boolean>singletonMap("available", false);
        }

        return Collections.singletonMap("available", employeeService.findByUsername(username) == null); //Checks database if username is found
    }

    @GetMapping(value = "/user/email/available", produces = "application/json; charset=UTF-8")
    public Map<String,Boolean> emailAvailable(@RequestParam("q")String email){
        if (email.length() < 4 || email.length() > 254) { //If email length is out of bounds, then violates databse rules and cannot exist. Returns false
            return Collections.<String, Boolean>singletonMap("available", false);
        }


        return Collections.singletonMap("available", employeeService.findByEmail(email) == null); //Checks database if email is found
    }


}
