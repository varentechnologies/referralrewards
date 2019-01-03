package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.dto.RecruiterQuestion;
import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.repository.EmployeeRepository;
import com.varentech.referralrewards.security.DefaultUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Collections;
import java.util.Map;
import java.util.StringJoiner;

@RestController
public class QuestionController {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Value("${email.recruiting}")
    public String recruitingEmail;


    @PostMapping(value = "/recruiting/question",  produces = "application/json; charset=UTF-8")
    public Map<String,Boolean> question(@RequestBody RecruiterQuestion question, @AuthenticationPrincipal DefaultUser principal){

        Employee employee = employeeRepository.findById(principal.getId());
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(message);
        StringJoiner joiner = new StringJoiner("<br>");
        joiner.add("<b>An employee asked a question...</b>");
        joiner.add("");
        joiner.add("<b>Email: </b>"+employee.getVarenEmail());
        joiner.add("<b>Question: </b>"+question.getQuestion());

        try {
            messageHelper.setTo(recruitingEmail);
            messageHelper.setSubject("New Question Received");
            messageHelper.setText(joiner.toString(), true);
        }catch(MessagingException e){
            return Collections.singletonMap("successful", false);
        }

        mailSender.send(messageHelper.getMimeMessage());


        return Collections.singletonMap("successful", true);

    }
}
