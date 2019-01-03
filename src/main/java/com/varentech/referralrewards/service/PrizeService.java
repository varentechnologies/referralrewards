package com.varentech.referralrewards.service;

import com.varentech.referralrewards.repository.PrizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PrizeService {

    @Autowired
    @Qualifier("prizeImpl")
    private PrizeRepository prizeRepository;

    @Transactional
    public boolean addNewPrize(String dateRedeemed, Long userId, String prizeLevel, String prizeName) {
        return prizeRepository.addNewPrize(dateRedeemed, userId, prizeLevel, prizeName);
    }
}
