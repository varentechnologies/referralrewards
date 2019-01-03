package com.varentech.referralrewards.repository;

import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PrizeRepository {

    public boolean addNewPrize(String dateRedeemed, Long userId, String prizeLevel, String prizeName);
    public List<Integer> getLevelsAlreadyRedeemed(long userId);
}
