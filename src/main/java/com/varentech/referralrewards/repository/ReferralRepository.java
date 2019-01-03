package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.model.Referral;

public interface ReferralRepository {

    Referral findEmpidByEmpemail(String varenEmployeeEmail);
    Referral add(Referral referral);
}
