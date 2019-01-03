package com.varentech.referralrewards.mappers;

import com.varentech.referralrewards.model.RecruiterInfoModel;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

    public class RecruitmentInfoMapper implements RowMapper<RecruiterInfoModel> {
        public RecruiterInfoModel mapRow(ResultSet rs, int rowNum) throws SQLException {
            RecruiterInfoModel candidate = new RecruiterInfoModel();
            candidate.setId(rs.getLong("ID No."));
            candidate.setLastName(rs.getString("Last Name"));
            candidate.setFirstName(rs.getString("First Name"));
            candidate.setClearanceLevel(rs.getString("Clearance Level"));
            candidate.setReferralWasMadeOn(rs.getString("Referral Made"));
            candidate.setInterviewed(rs.getString("Interview"));
            candidate.setOffer(rs.getString("Offer"));
            candidate.setHired(rs.getString("Hired"));
            candidate.setNotes(rs.getString("Notes/Comments"));

            return candidate;
        }
    }

