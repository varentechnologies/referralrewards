package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.model.LeaderboardInfoModel;
import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.service.LeaderboardInfo;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
public class LeaderboardController {

    @Autowired
    private LeaderboardInfo leaderboardInfoService;

    @GetMapping(value="/leaderboarddata", produces="application/json")
    public List<LeaderboardInfoModel> processLeaderboardInfo(@AuthenticationPrincipal DefaultUser principal) {
        System.out.println("reached");
        return leaderboardInfoService.addPoints(principal);


}
}