package com.varentech.referralrewards.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    /* Redirects user to admin panel - Spring Security checks if user has admin authority in
    'protected void configure' in WebSecurityConfig.java
     */
    @GetMapping("/admin")
    public String adminPanel(){
        return "admin";
    }
}
