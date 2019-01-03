package com.varentech.referralrewards.service;

import com.varentech.referralrewards.model.RecruiterInfoModel;
import com.varentech.referralrewards.repository.RecruiterInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;

@Service
public class RecruiterInfo {

    @Autowired
    @Qualifier("recruiterInfoImpl")
    private RecruiterInfoRepository recruiterInfo;

    @Transactional
    public List<RecruiterInfoModel> getAllCandidates() {
        return recruiterInfo.getAllCandidates();
    }

    @Transactional
    public List<RecruiterInfoModel> getDeletedCandidates(){
        return recruiterInfo.getDeletedCandidates();
    }

    @Transactional
    public boolean updateClearance(String clearanceLevel, int rowId) {
        return recruiterInfo.updateClearance(clearanceLevel, rowId);
    }

    @Transactional
    public boolean updateReferralDate(String refDate, int rowId) {
        return recruiterInfo.updateReferralDate(refDate, rowId);
    }

    @Transactional
    public boolean updateInterviewDate(String intDate, int rowId) {
        return recruiterInfo.updateInterviewDate(intDate, rowId);
    }
    @Transactional
    public boolean updateStatus(int status, int rowId){
        return recruiterInfo.updateStatus(status, rowId);
    }

    @Transactional
    public boolean updateOfferDate(String offDate, int rowId){
        return recruiterInfo.updateOfferDate(offDate, rowId);
    }

    @Transactional
    public boolean updateHireDate(String hireDate, int rowId) {
        return recruiterInfo.updateHireDate(hireDate, rowId);
    }

    @Transactional
    public boolean updateNotes(String notes, int rowId) {
        return recruiterInfo.updateNotes(notes, rowId);
    }

    @Transactional
    public boolean updateFutureCon(String futureCon, int rowId) {
        return recruiterInfo.updateFutureCon(futureCon, rowId);
    }

    @Transactional
    public boolean updateInPersonReferral(boolean inPersonReferral, int rowId){ return recruiterInfo.updateInPersonReferral(inPersonReferral,rowId);}

    @Transactional
    public boolean updateDelete(int rowId){
        return recruiterInfo.updateDelete(rowId);
    }

    @Transactional
    public boolean updateRecover(int rowId){
        return recruiterInfo.updateRecover(rowId);
    }
}

