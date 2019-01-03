package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.model.UserInfoModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.util.List;


@Repository
public class UserInfoImpl implements UserInfoRepository {

    @Autowired
    private JdbcTemplate employeeCandidateArray;

    public List<UserInfoModel> getUserCandidates(Object employeeid) {
        String sql = "SELECT id, lastName, firstName, submitDate, (CASE WHEN futureCon !=0 THEN 5 WHEN hired IS NOT NULL THEN 4 WHEN offer IS NOT NULL THEN 3 WHEN interviewed IS NOT NULL THEN 2 ELSE 1 END) AS status FROM referralcandidates WHERE employeeid = ?";
        RowMapper<UserInfoModel> rowMapper = new BeanPropertyRowMapper<UserInfoModel>(UserInfoModel.class);
        return this.employeeCandidateArray.query(sql, new Object[]{employeeid}, rowMapper);
    }


}