package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Referral;
import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.service.EmployeeService;
import com.varentech.referralrewards.service.ReferralService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RecruiterInfoController {
    @Autowired
    private ReferralService referralService;

    @Autowired
    private EmployeeService employeeService;

    //recruiter enters manual referral - takes input fields and puts to existing info for submit form
    @GetMapping("/recruiterinfo")
    public String processNewCandidate(Model model) {

        model.addAttribute(new Referral());
        return "infoForRecruiters";
    }



}
