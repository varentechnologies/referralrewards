package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.model.RecruiterInfoModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class RecruiterInfoImpl implements RecruiterInfoRepository{

    @Autowired
    private JdbcTemplate candidateArray;


    public List<RecruiterInfoModel> getAllCandidates() {
        String sql = "SELECT id, lastName, firstName, clearanceLevel, referralWasMadeOn, interviewed, offer, hired,futureCon, inPersonReferral, notes FROM referralcandidates WHERE isDeleted = false";
        RowMapper<RecruiterInfoModel> rowMapper = new BeanPropertyRowMapper<RecruiterInfoModel>(RecruiterInfoModel.class);
        return this.candidateArray.query(sql, rowMapper);
    }

    public List<RecruiterInfoModel> getDeletedCandidates(){
        String sql = "SELECT id, lastName, firstName, clearanceLevel, referralWasMadeOn, interviewed, offer, hired, futureCon, inPersonReferral, notes FROM referralcandidates WHERE isDeleted = true";
        RowMapper<RecruiterInfoModel> rowMapper = new BeanPropertyRowMapper<RecruiterInfoModel>(RecruiterInfoModel.class);
        return this.candidateArray.query(sql, rowMapper);
    }

    public boolean updateClearance(String clearanceLevel, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET clearanceLevel = ? WHERE id = ?", new Object[]{clearanceLevel, rowId}) == 1;
    }

    public boolean updateStatus(int status, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET referralcandidates.status = ? WHERE id = ?", new Object[]{status, rowId}) == 1;
    }

    public boolean updateReferralDate(String refDate, int rowId){
       return candidateArray.update("UPDATE referralcandidates SET referralWasMadeOn = ? WHERE id = ?", new Object[]{refDate, rowId}) == 1;
    }

    public boolean updateInterviewDate(String intDate, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET interviewed = ? WHERE id = ?", new Object[]{intDate, rowId}) == 1;
    }

    public boolean updateOfferDate(String offDate, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET offer = ? WHERE id = ?", new Object[]{offDate, rowId}) == 1;
    }

    public boolean updateHireDate(String hireDate, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET hired = ? WHERE id = ?", new Object[]{hireDate, rowId}) == 1;
    }

    public boolean updateNotes(String notes, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET notes = ? WHERE id = ?", new Object[]{notes, rowId}) == 1;
    }

    public boolean updateFutureCon(String futureCon, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET futureCon = ? WHERE id = ?", new Object[]{futureCon, rowId}) == 1;
    }

    public boolean updateInPersonReferral(boolean inPersonReferral, int rowId){
        return candidateArray.update("UPDATE referralcandidates SET inPersonReferral = ? WHERE id = ?", new Object[]{inPersonReferral,  rowId}) == 1;
    }


    public boolean updateDelete(int rowId){
        return candidateArray.update("UPDATE referralcandidates SET isDeleted = TRUE WHERE id = ?", new Object[]{rowId}) == 1;
    }

    public boolean updateRecover(int rowId){
        return candidateArray.update("UPDATE referralcandidates SET isDeleted = FALSE WHERE id = ?", new Object[]{rowId}) == 1;
    }


}
