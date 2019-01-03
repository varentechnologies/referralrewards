package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.LeaderboardInfoModel;

import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LeaderboardInfoRepository {

     List<LeaderboardInfoModel> getAllEmployees();
     List<LeaderboardInfoModel> getAllPoints();
     List<LeaderboardInfoModel> addPoints();

}
