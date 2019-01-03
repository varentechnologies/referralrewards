package com.varentech.referralrewards.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.varentech.referralrewards.model.LeaderboardInfoModel;
import org.springframework.jdbc.core.RowMapper;

public class LeaderboardInfoMapper implements RowMapper<LeaderboardInfoModel> {
    public LeaderboardInfoModel mapRow(ResultSet rs, int rowNum) throws SQLException {

            LeaderboardInfoModel employees = new LeaderboardInfoModel();
            employees.setId(rs.getLong("ID No"));
            employees.setLastName(rs.getString("Last Name"));
            employees.setFirstName(rs.getString("First Name"));
            employees.setPointsThisYear(rs.getInt("Points This Year"));
            employees.setPointsThisMonth(rs.getInt("Points This Month"));
            return employees;

    }
}


