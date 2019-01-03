package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.security.DefaultUserDetailsService;
import com.varentech.referralrewards.service.PointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MenuControllers {

    @Autowired
    private PointsService pointService;

    @GetMapping("/home")
    public String processHome(Model model){
        System.out.println("reached");
        return "index";
    }

    @Autowired
    DefaultUserDetailsService defaultUserDetailsService;

    @GetMapping("/info")
    public String processInfo(Model model, @AuthenticationPrincipal DefaultUser user){
        if(user.getAuthorities().contains( new SimpleGrantedAuthority("recruiter")) || user.getAuthorities().contains( new SimpleGrantedAuthority("admin")) || user.getAuthorities().contains( new SimpleGrantedAuthority("superadmin"))){
            return "infoForRecruiters";
        }
        else{
            return "infoForUsers";
        }



    }

    @GetMapping("/leaderboard")
    public String processLeaderboardInfo(Model model){
        System.out.println("reached");
        return "leaderboard";
    }

    @GetMapping("/prizes")
    public String processPrizes(Model model, @AuthenticationPrincipal DefaultUser user){
        Long pointsThisYear = pointService.getPointsLastYearByEmployeeId(user.getId());
        model.addAttribute("pointsThisYear", pointsThisYear);

        return "prizes";
    }

}
