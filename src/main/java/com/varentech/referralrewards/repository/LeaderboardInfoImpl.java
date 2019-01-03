package com.varentech.referralrewards.repository;
import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.LeaderboardInfoModel;
import com.varentech.referralrewards.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LeaderboardInfoImpl implements LeaderboardInfoRepository{

    @Autowired
    private JdbcTemplate employeesArray;

  public List<LeaderboardInfoModel>getAllEmployees(){
       String sql1 = "SELECT id, lastName, firstName FROM varendatabase.employeestats";
       RowMapper<LeaderboardInfoModel> rowMapper = new BeanPropertyRowMapper<LeaderboardInfoModel>(LeaderboardInfoModel.class);
       return this.employeesArray.query(sql1, rowMapper);
   }
   public List<LeaderboardInfoModel>getAllPoints() {
       String sql2 = "SELECT employeeId, pointsThisYear, pointsThisMonth FROM varendatabase.employeepoints ";
       RowMapper<LeaderboardInfoModel> rm = new BeanPropertyRowMapper<LeaderboardInfoModel>(LeaderboardInfoModel.class);
       return this.employeesArray.query(sql2, rm);

   }
   public List<LeaderboardInfoModel> addPoints() {
      String sql = "SELECT e.*, COALESCE(points_this_year,0) AS pointsThisYear, COALESCE(points_this_month,0) AS pointsThisMonth FROM\n" +
         "employeestats e LEFT JOIN\n" +
         "(\n" +
         "SELECT pv.employeeId, SUM(pv.total_points) AS points_this_year FROM\n" +
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
         "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL THEN 2\n" +
         "ELSE 0\n" +
         "END) AS offer_points,\n" +
         "(CASE\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel = 'fullycleared' THEN 8\n" +
         "WHEN referralWasMadeOn IS NOT NULL and hired IS NOT NULL and hired < NOW() THEN 4\n" +
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
         "pv\n" +
         "GROUP BY pv.employeeId\n" +
         ") q1 ON e.id = q1.employeeId LEFT JOIN\n" +
         "(\n" +
         "SELECT pv.employeeId, SUM(pv.total_points) AS points_this_month FROM\n" +
         "(\n" +
         "SELECT pt.*, (ref_points + interview_points + offer_points + hire_points + in_person_points) AS total_points FROM\n" +
         "(\n" +
         "SELECT rc.*,\n" +
         "(CASE\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND clearanceLevel = 'fullycleared' AND MONTH(referralWasMadeOn) = MONTH(CURRENT_DATE()) THEN 2\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND MONTH(referralWasMadeOn) = MONTH(CURRENT_DATE()) THEN 1\n" +
         "ELSE 0\n" +
         "END) AS ref_points,\n" +
         "(CASE\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND clearanceLevel = 'fullycleared' AND MONTH(interviewed) = MONTH(CURRENT_DATE()) THEN 4\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND interviewed IS NOT NULL AND MONTH(interviewed) = MONTH(CURRENT_DATE()) THEN 2\n" +
         "ELSE 0\n" +
         "END) AS interview_points,\n" +
         "(CASE\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL AND clearanceLevel = 'fullycleared' AND MONTH(offer) = MONTH(CURRENT_DATE()) THEN 4\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND offer IS NOT NULL AND MONTH(offer) = MONTH(CURRENT_DATE()) THEN 2\n" +
         "ELSE 0\n" +
         "END) AS offer_points,\n" +
         "(CASE\n" +
         "WHEN referralWasMadeOn IS NOT NULL AND hired IS NOT NULL AND hired < NOW() AND clearanceLevel = 'fullycleared' AND MONTH(hired) = MONTH(CURRENT_DATE()) THEN 8\n" +
         "WHEN referralWasMadeOn IS NOT NULL and hired IS NOT NULL and hired < NOW() AND MONTH(hired) = MONTH(CURRENT_DATE()) THEN 4\n" +
         "ELSE 0\n" +
         "END) AS hire_points,\n" +
         "(CASE\n" +
         "WHEN inPersonReferral = TRUE AND clearanceLevel = 'fullycleared' THEN 2\n" +
         "WHEN inPersonReferral = TRUE THEN 1\n"+
         "ELSE 0\n" +
         "END) AS in_person_points\n"+
         "FROM referralcandidates rc WHERE (MONTH(rc.referralWasMadeOn) = MONTH(CURRENT_DATE()) OR MONTH(rc.interviewed) = MONTH(CURRENT_DATE()) OR MONTH(rc.offer) = MONTH(CURRENT_DATE()) OR MONTH(rc.hired) = MONTH(CURRENT_DATE())) AND rc.status != '1' AND rc.isDeleted IS FALSE\n" +
         ") pt\n" +
         ")\n" +
         "pv\n" +
         "GROUP BY pv.employeeId\n" +
         ") q2 ON q1.employeeId = q2.employeeId\n" +
         ";";
      return employeesArray.query(sql, new BeanPropertyRowMapper(LeaderboardInfoModel.class));
  }
}

