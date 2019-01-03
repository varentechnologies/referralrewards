package com.varentech.referralrewards.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.*;

/*This Repository does not correspond to a physical database table. Queries the 'referralcandidates' table
and calculates referral points within time ranges (last year / last month) and total points
 */
@Repository
public class PointsRepositoryImpl implements PointsRepository {

    @Autowired
    private JdbcTemplate template;

    //Returns the number of points last month an employee has based on their employee ID number
    public Long getPointsLastMonthByEmployeeId(long employeeId) {
        String sql = "SELECT SUM(total_points) AS final_total FROM\n" +
                "(\n" +
                "SELECT pt.*, (ref_points + interview_points + offer_points + hire_points + in_person_points) AS total_points FROM\n" +
                "(\n" +
                "SELECT rc.*,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN referralWasMadeOn IS NOT NULL THEN 1\n" +
                "ELSE 0\n" +
                "END) AS ref_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL THEN 2\n" +
                "ELSE 0\n" +
                "END) AS interview_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL  THEN 2\n" +
                "ELSE 0\n" +
                "END) AS offer_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel = 'fullycleared' THEN 8\n" +
                "WHEN referralWasMadeOn IS NOT NULL and hired IS NOT NULL AND hired < NOW()  THEN 4\n" +
                "ELSE 0\n" +
                "END) AS hire_points,\n" +
                "(CASE\n" +
                "WHEN inPersonReferral = TRUE AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN inPersonReferral = TRUE THEN 1\n"+
                "ELSE 0\n" +
                "END) AS in_person_points\n"+
                "FROM referralcandidates rc WHERE rc.referralWasMadeOn >= DATE_FORMAT(NOW(), '%Y-%m-01') AND rc.status != '1' AND rc.isDeleted IS FALSE\n" +
                ") pt\n" +
                ")\n" +
                "pv WHERE pv.employeeId = ? GROUP BY pv.employeeId;\n" +
                ";";

        Long result = 0L;
        try {
            result = template.queryForObject(sql, new Object[]{employeeId}, Long.class);
        } catch (EmptyResultDataAccessException e) {

        }
        return result;
    }

    //Allows querying points by a list of IDs, returns a map that maps employee id to their points
    public Map<Long, Long> getPointsLastMonthByEmployeeId(List<Long> employeeIds) {

        //If the list is empty, avoids querying the database and returns an empty result
        if (employeeIds.isEmpty()) {
            return new HashMap<>();
        }

        String employees = "(";
        StringJoiner employeeIdJoiner = new StringJoiner(",");
        for (Long id : employeeIds) {
            employeeIdJoiner.add("'" + id + "'");
        }
        employees += employeeIdJoiner.toString() + ")";

        String sql = "SELECT pv.employeeId, SUM(total_points) AS final_total FROM \n" +
                "(\n" +
                "SELECT pt.*, (ref_points + interview_points + offer_points + hire_points + in_person_points) AS total_points FROM\n" +
                "(\n" +
                "SELECT rc.*,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN referralWasMadeOn IS NOT NULL  THEN 1\n" +
                "ELSE 0\n" +
                "END) AS ref_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL THEN 2\n" +
                "ELSE 0\n" +
                "END) AS interview_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL THEN 2\n" +
                "ELSE 0\n" +
                "END) AS offer_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel = 'fullycleared' THEN 8\n" +
                "WHEN referralWasMadeOn IS NOT NULL and hired IS NOT NULL AND hired < NOW()  THEN 4\n" +
                "ELSE 0\n" +
                "END) AS hire_points,\n" +
                "(CASE\n" +
                "WHEN inPersonReferral = TRUE AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN inPersonReferral = TRUE THEN 1\n"+
                "ELSE 0\n" +
                "END) AS in_person_points\n"+
                "FROM referralcandidates rc WHERE rc.referralWasMadeOn >= DATE_FORMAT(NOW(), '%Y-%m-01') AND rc.status != '1' AND rc.isDeleted IS FALSE\n" +
                ") pt\n" +
                ")\n" +
                "pv";

        String whereClause = " WHERE pv.employeeId IN " + employees;
        whereClause += " GROUP BY pv.employeeId";
        sql += whereClause;
        System.out.println(sql);
        List<Map<String, Object>> results = template.queryForList(sql);

        Map<Long, Long> toReturn = new HashMap<>();

        for(Long id: employeeIds){
            toReturn.put(id,0L);
        }
        for (Map<String, Object> row : results) {

            Long id = (Long) row.get("employeeId");
            Long points = ((BigDecimal)row.get("final_total")).longValue();
            toReturn.put(id, points);
        }

        return toReturn;

    }


    public Long getPointsLastYearByEmployeeId(long employeeId){
        String sql = "SELECT SUM(total_points) AS final_total FROM\n" +
                "(\n" +
                "SELECT pt.*, (ref_points + interview_points + offer_points + hire_points + in_person_points) AS total_points FROM\n" +
                "(\n" +
                "SELECT rc.*,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN referralWasMadeOn IS NOT NULL  THEN 1\n" +
                "ELSE 0\n" +
                "END) AS ref_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL  THEN 2\n" +
                "ELSE 0\n" +
                "END) AS interview_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL  THEN 2\n" +
                "ELSE 0\n" +
                "END) AS offer_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel = 'fullycleared' THEN 8\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() THEN 4\n" +
                "ELSE 0\n" +
                "END) AS hire_points,\n" +
                "(CASE\n" +
                "WHEN inPersonReferral = TRUE AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN inPersonReferral = TRUE THEN 1\n"+
                "ELSE 0\n" +
                "END) AS in_person_points\n"+
                "FROM referralcandidates rc WHERE rc.referralWasMadeOn >= DATE_FORMAT(NOW(), '%Y-01-01') AND rc.status != '1' and rc.isDeleted IS FALSE\n" +
                ") pt\n" +
                ")\n" +
                "pv WHERE pv.employeeId = ? GROUP BY pv.employeeId;\n" +
                ";";

        Long result = 0L;
        try {
            result = template.queryForObject(sql, new Object[]{employeeId}, Long.class);
        } catch (EmptyResultDataAccessException e) {

        }
        return result;

    }

    public Map<Long,Long> getPointsLastYearByEmployeeId(List<Long> employeeIds){
        //If the list is empty, avoids querying the database and returns an empty result
        if (employeeIds.isEmpty()) {
            return new HashMap<>();
        }

        String employees = "(";
        StringJoiner employeeIdJoiner = new StringJoiner(",");
        for (Long id : employeeIds) {
            employeeIdJoiner.add("'" + id + "'");
        }
        employees += employeeIdJoiner.toString() + ")";

        String sql = "SELECT pv.employeeId, SUM(total_points) AS final_total FROM\n" +
                "(\n" +
                "SELECT pt.*, (ref_points + interview_points + offer_points + hire_points + in_person_points) AS total_points FROM\n" +
                "(\n" +
                "SELECT rc.*,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN referralWasMadeOn IS NOT NULL  THEN 1\n" +
                "ELSE 0\n" +
                "END) AS ref_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL THEN 2\n" +
                "ELSE 0\n" +
                "END) AS interview_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL AND clearanceLevel = 'fullycleared' THEN 4\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL  THEN 2\n" +
                "ELSE 0\n" +
                "END) AS offer_points,\n" +
                "(CASE\n" +
                "WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel = 'fullycleared' THEN 8\n" +
                "WHEN referralWasMadeOn IS NOT NULL and hired IS NOT NULL AND hired < NOW() THEN 4\n" +
                "ELSE 0\n" +
                "END) AS hire_points,\n" +
                "(CASE\n" +
                "WHEN inPersonReferral = TRUE AND clearanceLevel = 'fullycleared' THEN 2\n" +
                "WHEN inPersonReferral = TRUE THEN 1\n"+
                "ELSE 0\n" +
                "END) AS in_person_points\n"+
                "FROM referralcandidates rc WHERE rc.referralWasMadeOn >= DATE_FORMAT(NOW(), '%Y-01-01') AND rc.status != '1' AND rc.isDeleted IS FALSE\n" +
                ") pt\n" +
                ")\n" +
                "pv";

        String whereClause = " WHERE pv.employeeId IN " + employees;
        whereClause += " GROUP BY pv.employeeId";
        sql += whereClause;
        System.out.println(sql);
        List<Map<String, Object>> results = template.queryForList(sql);

        Map<Long, Long> toReturn = new HashMap<>();
        for(Long id: employeeIds){
            toReturn.put(id,0L);
        }

        for (Map<String, Object> row : results) {

            Long id = (Long) row.get("employeeId");
            Long points = ((BigDecimal)row.get("final_total")).longValue();
            toReturn.put(id, points);
        }

        return toReturn;
    }


}
