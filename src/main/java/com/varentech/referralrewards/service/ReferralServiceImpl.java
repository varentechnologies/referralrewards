package com.varentech.referralrewards.service;


import com.varentech.referralrewards.model.Referral;
import com.varentech.referralrewards.repository.ReferralRepository;
import com.varentech.referralrewards.repository.ReferralRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;

@Service
public class ReferralServiceImpl implements ReferralService{

    @Autowired
    @Qualifier("referralRepositoryImpl")
    public ReferralRepositoryImpl referralRepository;

    @Transactional
    public Referral addReferral(Referral referral){
        return referralRepository.add(referral);

    }

}
