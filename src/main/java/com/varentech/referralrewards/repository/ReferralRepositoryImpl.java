package com.varentech.referralrewards.repository;


import com.varentech.referralrewards.mappers.ReferralRowMapper;
import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Referral;
import com.varentech.referralrewards.model.Role;
import com.varentech.referralrewards.service.ReferralService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;

@Repository
public class ReferralRepositoryImpl implements ReferralRepository {

    @Autowired
    private JdbcTemplate template;

    @Autowired
    private NamedParameterJdbcTemplate namedTemplate;


    @Transactional
    public Referral add(Referral referral){

       template.update(
               "INSERT INTO varendatabase.referralcandidates(submitDate, lastName,firstName,clearanceLevel, candidateEmail,candidatePhone,possiblePosition, " +
                       "knownBy,qualifications, varenEmployeeEmail, employeeId, anon, resume, referralWasMadeOn, interviewed, offer, hired, notes, status, futureCon)VALUES " +
                       "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", referral.getSubmitDate(),referral.getLastName(), referral.getFirstName(),
                        referral.getClearanceLevel(), referral.getCandidateEmail(), referral.getCandidatePhone(), referral.getPossiblePosition(),
                        referral.getKnownBy(), referral.getQualifications(), referral.getEmpemail(), referral.getEmployeeId(), referral.getAnon(),
                        referral.getResume(), referral.getReferralWasMadeOn(), referral.getInterviewed(), referral.getOffer(), referral.getHired(),
                        referral.getNotes(), referral.getStatus(), "");
        return referral;
    }
    public Referral findEmpidByEmpemail(String varenEmployeeEmail){
        List<Referral> results = template.query("SELECT employeestats.id, employeestats.varenEmail FROM employeestats RIGHT JOIN referralcandidates ON employeestats.varenEmail = referralcandidates.empemail", new Object[]{varenEmployeeEmail}, new BeanPropertyRowMapper(Referral.class));
        return results.isEmpty() ? null : results.get(0);
    }
}
