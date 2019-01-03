package com.varentech.referralrewards.service;

import com.varentech.referralrewards.repository.PointsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class PointsService {

    @Autowired
    private PointsRepository pointsRepository;

    @Transactional(readOnly = true)
    public Long getPointsLastMonthByEmployeeId(long employeeId){
        return pointsRepository.getPointsLastMonthByEmployeeId(employeeId);
    }

    @Transactional(readOnly = true)
    public Map<Long,Long> getPointsLastMonthByEmployeeId(List<Long> employeeIds){
        return pointsRepository.getPointsLastMonthByEmployeeId(employeeIds);
    }

    @Transactional(readOnly = true)
    public Long getPointsLastYearByEmployeeId(long employeeId){
        return pointsRepository.getPointsLastYearByEmployeeId(employeeId);
    }

    @Transactional(readOnly = true)
    public Map<Long,Long> getPointsLastYearByEmployeeId(List<Long> employeeIds){
        return pointsRepository.getPointsLastYearByEmployeeId(employeeIds);
    }
}
