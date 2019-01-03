package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.model.Referral;
import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.service.ReferralService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.StringJoiner;

@Controller
public class FormController {

    @Autowired
    private ReferralService referralService;

    @Autowired
    public JavaMailSender emailSender;

    @Value("${email.recruiting}")
    private String recruitingEmail;


    @GetMapping(value = {"/submit"} )
    public String processSubmit(Model model) {
        System.out.println("reached");
        model.addAttribute("refform", new Referral());
        return "submit";
    }

    @PostMapping(value = "/refer")
    public String processForm(@ModelAttribute Referral referral, @RequestParam("file")MultipartFile file, @AuthenticationPrincipal DefaultUser principal)
            throws MessagingException, IOException {

        String anonymous = referral.getAnon().equals("0") ? "No" : "Yes";

        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setTo(recruitingEmail);
        helper.setSubject("Referral Submitted");



        StringJoiner joiner = new StringJoiner("<br>");
        joiner.add("<b>This is an automated email from LEAD THE WAY - Varen's Employee Referral Program</b>");
        joiner.add("");
        joiner.add("<b>An employee referral was submitted by</b>");
        joiner.add("<b>Last Name:</b> "+principal.getLastname());
        joiner.add("<b>First Name:</b> "+principal.getFirstname());
        joiner.add("<b>Employee Email:</b> "+referral.getEmpemail());
        joiner.add("<b>Date Submitted:</b> "+referral.getSubmitDate());
        joiner.add("");
        joiner.add("<b>Referral Candidate Information</b>");
        joiner.add("<b>Last Name:</b> "+referral.getLastName());
        joiner.add("<b>First Name:</b> "+referral.getFirstName());
        joiner.add("<b>Email:</b> "+referral.getCandidateEmail());
        joiner.add("<b>Phone:</b> "+referral.getCandidatePhone());
        String clearanceLevel = referral.getClearanceLevel().equals("1") ? "Fully Cleared" : "Not Fully Cleared";
        joiner.add("<b>Clearance Level:</b> "+clearanceLevel);


        joiner.add("<b>Position Referred For:</b> "+referral.getPossiblePosition());
        joiner.add("<b>Relationship to Employee:</b> "+referral.getKnownBy());
        joiner.add("<b>Listed Qualifications:</b> "+referral.getQualifications());
        joiner.add("<b>Should the employee be anonymous:</b> "+anonymous);
        joiner.add("");
        joiner.add("<b>Comments: </b>");
        joiner.add(referral.getComment());

        if(!file.isEmpty()) {
            File resume = File.createTempFile("referral-", "" + referral.getEmployeeId());
            file.transferTo(resume);
            helper.addAttachment(file.getOriginalFilename(), resume);

            referral.setReferralWasMadeOn(new Date());
        }

        String messageBody = joiner.toString();
        helper.setText(messageBody, true);
        emailSender.send(helper.getMimeMessage());

        referral.setEmployeeId(principal.getId().intValue());

        //Data transformation to database
        if(principal.getAuthorities().contains(new SimpleGrantedAuthority("leader"))){
            referral.setStatus(1);
        }
        if(referral.getClearanceLevel().equals("1")){
            referral.setClearanceLevel("fullycleared");
        }
        else{
            referral.setClearanceLevel("notcleared");
        }
        referralService.addReferral(referral);
        return "submit";
    }


}

