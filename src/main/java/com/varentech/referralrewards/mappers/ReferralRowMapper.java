package com.varentech.referralrewards.mappers;

import com.varentech.referralrewards.model.Referral;

import javax.swing.tree.RowMapper;
import java.sql.*;

public class ReferralRowMapper implements org.springframework.jdbc.core.RowMapper<Referral> {


    public Referral mapRow(ResultSet rs, int rowNum) throws SQLException
    {
        Referral referral = new Referral();
        referral.setSubmitDate(rs.getString("submitdate"));
        referral.setLastName(rs.getString("lastName"));
        referral.setFirstName(rs.getString("firstName"));
        referral.setClearanceLevel(rs.getString("clearanceLevel"));
        referral.setCandidateEmail(rs.getString("candidateEmail"));
        referral.setCandidatePhone(rs.getString("candidatePhone"));
        referral.setPossiblePosition(rs.getString("possiblePosition"));
        referral.setKnownBy(rs.getString("knownBy"));
        referral.setQualifications(rs.getString("qualifications"));
        referral.setEmpemail(rs.getString("varenEmployeeEmail"));
        referral.setEmployeeId(rs.getInt("employeeId"));
        referral.setAnon(rs.getString("anon"));
        referral.setResume(rs.getString("resume"));
        referral.setReferralWasMadeOn(rs.getDate("referralwasmadeon"));
        referral.setInterviewed(rs.getDate("interviewed"));
        referral.setOffer(rs.getDate("offered"));
       referral.setHired(rs.getDate("hired"));
       referral.setNotes(rs.getString("notes"));
       referral.setStatus(rs.getInt("status"));
        return referral;
    }

}
