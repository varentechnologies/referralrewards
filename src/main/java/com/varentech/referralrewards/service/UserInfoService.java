package com.varentech.referralrewards.service;


import com.varentech.referralrewards.model.UserInfoModel;
import com.varentech.referralrewards.repository.UserInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserInfoService {

    @Autowired
    @Qualifier("userInfoImpl")
    private UserInfoRepository userRepository;

    @Transactional
    public List<UserInfoModel> getUserCandidates(Object userId) {
        return userRepository.getUserCandidates(userId);
    }
}
