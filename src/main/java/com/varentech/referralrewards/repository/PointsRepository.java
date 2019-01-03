package com.varentech.referralrewards.repository;


import java.util.List;
import java.util.Map;

/* Repository that calculates an employees points within the last month and last year based on their employee ID.
The functions that accept a single employee ID value will return their points last month / last year depending on the function.
The functions that accept a list of employee IDs will return a map that maps the given employee IDs to their points last month / last year.

Note: These are the points that the employee has earned in total within last month / last year timeframes. This is NOT equivalent
to the amount of points they have to spend. These functions should not be used to redeem prizes for employees.
 */
public interface PointsRepository {

    Long getPointsLastMonthByEmployeeId(long employeeId);
    Map<Long,Long> getPointsLastMonthByEmployeeId(List<Long> employeeIds);
    Long getPointsLastYearByEmployeeId(long employeeId);
    Map<Long,Long> getPointsLastYearByEmployeeId(List<Long> employeeIds);



}
