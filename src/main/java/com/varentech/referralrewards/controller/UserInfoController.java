package com.varentech.referralrewards.controller;


import com.varentech.referralrewards.model.UserInfoModel;
import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserInfoController{
   @Autowired
   private UserInfoService userInfoService;

    @GetMapping(value = "/userinfo", produces = "application/json")
    public List<UserInfoModel> processUserCandidates(@AuthenticationPrincipal DefaultUser principal) {
        long userId = principal.getId();
        System.out.println("reached");
        return userInfoService.getUserCandidates(userId);
    }


}
