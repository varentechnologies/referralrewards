package com.varentech.referralrewards.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import com.varentech.referralrewards.model.RecruiterInfoModel;
import com.varentech.referralrewards.model.UserInfoModel;
import org.springframework.jdbc.core.RowMapper;

public class UserInfoMapper implements RowMapper<UserInfoModel> {
    public UserInfoModel mapRow(ResultSet rs, int rowNum) throws SQLException {
        UserInfoModel userCandidate = new UserInfoModel();
        userCandidate.setId(rs.getLong("ID No."));
        userCandidate.setLastName(rs.getString("Last Name"));
        userCandidate.setFirstName(rs.getString("First Name"));
        userCandidate.setSubmitDate(rs.getString("Date Submitted"));
        userCandidate.setStatus(rs.getString("status"));
        return userCandidate;

    }
}
