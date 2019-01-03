package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.model.RecruiterInfoModel;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecruiterInfoRepository {

    public List<RecruiterInfoModel> getAllCandidates();

    public List<RecruiterInfoModel> getDeletedCandidates();

    public boolean updateClearance(String clearance, int rowId);

    public boolean updateReferralDate(String refDate, int rowId);

    public boolean updateInterviewDate(String intDate, int rowId);

    public boolean updateOfferDate(String offDate, int rowId);

    public boolean updateHireDate(String offDate, int rowId);

    public boolean updateNotes(String notes, int rowId);

    public boolean updateFutureCon(String futureCon, int rowId);

    public boolean updateInPersonReferral(boolean inPersonReferral, int rowId);

    public boolean updateDelete(int rowId);

    public boolean updateRecover(int rowId);

    public boolean updateStatus(int status, int rowId);


}
