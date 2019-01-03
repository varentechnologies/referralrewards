package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.dto.CandidateDateUpdates;
import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.RecruiterInfoModel;
import com.varentech.referralrewards.model.Referral;
import com.varentech.referralrewards.model.Role;
import com.varentech.referralrewards.repository.EmployeeRepository;
import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.service.EmployeeService;
import com.varentech.referralrewards.service.RecruiterInfo;
import com.varentech.referralrewards.service.ReferralService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.*;


@RestController
public class RecruiterInfoRestController {

    @Autowired
    private RecruiterInfo recruiterInfoService;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private ReferralService referralService;

    @Autowired
    public JavaMailSender emailSender;

    @Value("${email.recruiting}")
    private String recruitingEmail;

    @Autowired
    private EmployeeRepository employeeRepository;

    @GetMapping(value = "/recruiterinfo", produces = "application/json")
    public List<RecruiterInfoModel> processRecruiterInfo() {
        return recruiterInfoService.getAllCandidates();
    }

    @GetMapping(value = "/deletedrecruiterinfo", produces = "application/json")
    public List<RecruiterInfoModel> processDeletedRecruiterInfo(@AuthenticationPrincipal DefaultUser user){
        if(user.getAuthorities().contains(new SimpleGrantedAuthority("admin")) || user.getAuthorities().contains(new SimpleGrantedAuthority("superadmin"))){
            return recruiterInfoService.getDeletedCandidates();
        }
        return new ArrayList<>(); //If user is not an admin or superadmin, does not allow them to view deleted referrals. Just returns empty list.
    }

    @PostMapping("/clearanceupdates")
    public boolean clearanceUpdate(@RequestBody CandidateDateUpdates newClearanceLevel) {
        int rowId = Integer.parseInt(newClearanceLevel.getRowIdNo());
        String clearanceLevel = newClearanceLevel.getClearanceLevel();
        return recruiterInfoService.updateClearance(clearanceLevel, rowId);
    }
    @PostMapping("/statusupdates")
    public boolean statusUpdate(@RequestBody CandidateDateUpdates newStatus) {
        int rowId = Integer.parseInt(newStatus.getRowIdNo());
        int status = newStatus.getStatus();
        return recruiterInfoService.updateStatus(status, rowId);
    }
    @PostMapping("/referraldateupdates")
    public boolean referralDateUpdate(@RequestBody CandidateDateUpdates newReferralDate) {
        int rowId = Integer.parseInt(newReferralDate.getRowIdNo());
        String refDate = newReferralDate.getRefDate();
        return recruiterInfoService.updateReferralDate(refDate, rowId);
    }

    @PostMapping("/interviewdateupdates")
    public boolean interviewDateUpdate(@RequestBody CandidateDateUpdates newInterviewDate) {
        int rowId = Integer.parseInt(newInterviewDate.getRowIdNo());
        String intDate = newInterviewDate.getIntDate();
        return recruiterInfoService.updateInterviewDate(intDate, rowId);
    }

    @PostMapping("/offerdateupdates")
    public boolean offerDateUpdate(@RequestBody CandidateDateUpdates newOfferDate) {
        int rowId = Integer.parseInt(newOfferDate.getRowIdNo());
        String offDate = newOfferDate.getOffDate();
        return recruiterInfoService.updateOfferDate(offDate, rowId);
    }

    @PostMapping("/hiredateupdates")
    public boolean hireDateUpdate(@RequestBody CandidateDateUpdates newHireDate) {
        int rowId = Integer.parseInt(newHireDate.getRowIdNo());
        String hireDate = newHireDate.getHireDate();
        return recruiterInfoService.updateHireDate(hireDate, rowId);
    }

    @PostMapping("/notesupdates")
    public boolean notesUpdate(@RequestBody CandidateDateUpdates newNotes) {
        int rowId = Integer.parseInt(newNotes.getRowIdNo());
        String notes = newNotes.getNotes();
        return recruiterInfoService.updateNotes(notes, rowId);
    }

    @PostMapping("/futureupdates")
    public boolean futureUpdate(@RequestBody CandidateDateUpdates newFutureConsideration) {
        int rowId = Integer.parseInt(newFutureConsideration.getRowIdNo());
        String futureCon = newFutureConsideration.getFutureCon();
        return recruiterInfoService.updateFutureCon(futureCon, rowId);
    }

    @PostMapping("inpersonreferralupdates")
    public boolean inPersonReferralUpdate(@RequestBody CandidateDateUpdates newInPersonReferral) {

        int rowId = Integer.parseInt(newInPersonReferral.getRowIdNo());
        boolean inPersonReferral = newInPersonReferral.isInPersonReferral();

        return recruiterInfoService.updateInPersonReferral(inPersonReferral, rowId);
    }

    @PostMapping("deleteupdates")
    public boolean deleteUpdate(@RequestBody CandidateDateUpdates delete){
        int rowId = Integer.parseInt(delete.getRowIdNo());

        return recruiterInfoService.updateDelete(rowId);
    }

    @PostMapping("recoverupdates")
    public boolean recoverUpdate(@RequestBody CandidateDateUpdates recover){
        int rowId = Integer.parseInt(recover.getRowIdNo());
        return recruiterInfoService.updateRecover(rowId);
    }

    @PostMapping(value = "/referral",produces = "application/json")
    public Map<String,Boolean> processNewCandidate(@ModelAttribute Referral referral, @AuthenticationPrincipal DefaultUser principal) throws MessagingException {



        String anonymous = referral.getAnon().equals("0") ? "No" : "Yes";

        //Recruiter makes manual referral. If employee email submitted does not exist, reject
        String email = referral.getEmpemail();
        Employee employee = employeeService.findByEmail(email);
        if(employee == null){
            return Collections.singletonMap("success",false);
        }

        List<Role> employeeRoles = employeeRepository.getRolesByEmail(employee.getVarenEmail());
        if(employeeRoles.contains(new Role("leader"))){
            referral.setStatus(1);
        }

        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setTo(recruitingEmail);
        helper.setSubject("Manual Referral Submitted");

        StringJoiner joiner = new StringJoiner("<br>");
        joiner.add("<b>This is an automated email from LEAD THE WAY - Varen's Employee Referral Program</b>");
        joiner.add("");
        joiner.add("<b>A manual referral was submitted by: </b>"+principal.getFirstname()+" "+principal.getLastname());
        joiner.add("<b>On behalf of:</b> "+referral.getEmpemail());
        joiner.add("<b>Date Submitted:</b> "+referral.getSubmitDate());
        joiner.add("");
        joiner.add("<b>Referral Candidate Information</b>");
        joiner.add("<b>Candidate Last Name:</b> "+referral.getLastName());
        joiner.add("<b>Candidate First Name:</b> "+referral.getFirstName());
        joiner.add("<b>Should Employee Be Anonymous: </b>"+anonymous);

        String messageBody = joiner.toString();
        helper.setText(messageBody, true);
        emailSender.send(helper.getMimeMessage());



        referral.setClearanceLevel("notcleared");
        referral.setEmployeeId(employee.getId().intValue());



        referralService.addReferral(referral);
        return Collections.<String, Boolean>singletonMap("success", true);
    }

}