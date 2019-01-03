package com.varentech.referralrewards.service;

import com.varentech.referralrewards.model.LeaderboardInfoModel;
import com.varentech.referralrewards.repository.LeaderboardInfoRepository;
import com.varentech.referralrewards.security.DefaultUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class LeaderboardInfo {

    @Autowired
    @Qualifier("leaderboardInfoImpl")
    private LeaderboardInfoRepository leaderboardInfo;

   @Transactional
    public List<LeaderboardInfoModel> getAllEmployees() { return leaderboardInfo.getAllEmployees();}

    @Transactional
    public List<LeaderboardInfoModel> getAllPoints(){ return leaderboardInfo.getAllPoints();}

    @Transactional
    public List<LeaderboardInfoModel> addPoints(DefaultUser principal) {
        List<LeaderboardInfoModel> results = leaderboardInfo.addPoints();

        if (principal.getAuthorities().contains(new SimpleGrantedAuthority("superadmin"))) {
            return results;
        }
        return results.stream().filter(element -> element.getPointsThisYear() > 0).collect(Collectors.toList());
    }
}
