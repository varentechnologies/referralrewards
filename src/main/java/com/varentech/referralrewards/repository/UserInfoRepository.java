package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.model.UserInfoModel;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserInfoRepository {

    public List<UserInfoModel> getUserCandidates(Object userId);
}
