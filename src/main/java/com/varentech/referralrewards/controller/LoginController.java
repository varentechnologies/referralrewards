package com.varentech.referralrewards.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
public class LoginController {


   /* @PostMapping("/loginerror")
    public String processLoginError(){
        System.out.println("reached");
        return "error";
    }*/

    @GetMapping("/login")
    public String processLogin(Principal principal) {
        System.out.println("reached");

        if(principal != null){
            return "forward:/";
        }
        return "login_minimal";
    }

    @GetMapping("/")
    public String processIndex(Model model) {
        model.addAttribute("message", "testing");
        return "index";
    }

    @PostMapping("/")
    public String processIndexPost() {
        return "index";
    }

 /*   @GetMapping("employee")
    public String employeeTest() {
        System.out.println(employeeService.findByUsername(""));

        return "index";
    }*/




}

