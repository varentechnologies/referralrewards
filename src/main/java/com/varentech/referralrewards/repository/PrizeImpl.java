package com.varentech.referralrewards.repository;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class PrizeImpl implements PrizeRepository{

    @Autowired
    private JdbcTemplate template;

    public boolean addNewPrize(String dateRedeemed, Long userId, String prizeLevel, String prizeName){
        return template.update("INSERT INTO prizesreceived (dateRedeemed, employeeId, levelRedeemed, prizeName) VALUES (?, ?, ?, ? )", new Object[]{dateRedeemed, userId, prizeLevel, prizeName}) ==1;
    }

    public List<Integer> getLevelsAlreadyRedeemed(long userId){
        List<Integer> toReturn = new ArrayList<>();

        List<Map<String,Object>> rows = template.queryForList("SELECT * FROM prizesreceived WHERE employeeId = ? AND dateRedeemed >= DATE_FORMAT(NOW(), '%Y-01-01')", new Object[]{userId});

        for(Map<String,Object> row : rows){
            toReturn.add(Integer.parseInt(row.get("levelRedeemed").toString()));
        }
        return toReturn;
    }

}
