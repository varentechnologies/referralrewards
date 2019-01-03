package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.dto.NewPrizeRedeemed;
import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.repository.EmployeeRepository;
import com.varentech.referralrewards.security.DefaultUser;
import com.varentech.referralrewards.service.PrizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.StringJoiner;

@RestController
public class PrizeController {

    @Autowired
    private PrizeService prizeService;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Value("${email.recruiting}")
    private String recruitingEmail;



    @PostMapping("/prizeredeemed")
    public boolean prizeRedeemedUpdate(@RequestBody NewPrizeRedeemed newPrizeRedeemed, @AuthenticationPrincipal DefaultUser principal) throws MessagingException{
        String dateRedeemed = newPrizeRedeemed.getDateRedeemed();

        Long userId = principal.getId();
        String prizeLevel = newPrizeRedeemed.getPrizeLevel();
        String prizeName = newPrizeRedeemed.getPrizeName();

        MimeMessage recruitingMessage =  mailSender.createMimeMessage();
        MimeMessageHelper recruitingHelper = new MimeMessageHelper(recruitingMessage);

        MimeMessage managerMessage = mailSender.createMimeMessage();
        MimeMessageHelper managerHelper = new MimeMessageHelper(managerMessage);

        Employee employee = employeeRepository.findById(principal.getId());

        recruitingHelper.setTo(recruitingEmail);
        managerHelper.setTo(newPrizeRedeemed.getManageremail());
        StringJoiner recruitingJoiner = new StringJoiner("<br>");

        recruitingJoiner.add("<b>Prize Details:</b>");
        recruitingJoiner.add("<b>Last Name:</b> "+principal.getLastname());
        recruitingJoiner.add("<b>First Name:</b> "+principal.getFirstname());
        recruitingJoiner.add("<b>Email: </b>"+employee.getVarenEmail());
        recruitingJoiner.add("<b>Prize Name:</b> "+prizeName);
        recruitingJoiner.add("<b>Prize Level: </b>"+prizeLevel);
        recruitingJoiner.add("<b>Date Redeemed: </b>"+newPrizeRedeemed.getDateRedeemed());
        recruitingJoiner.add("");
        managerHelper.setText(recruitingJoiner.toString(),true);
        managerHelper.setSubject("LEAD THE WAY - New Prize Redeemed");
        mailSender.send(managerHelper.getMimeMessage());


        if(newPrizeRedeemed.getStreetaddress() != null){
            recruitingJoiner.add("<b>Mailing Information</b>");
            recruitingJoiner.add("<b>Street Address: </b>" + newPrizeRedeemed.getStreetaddress());
            recruitingJoiner.add("<b>City: </b>"+newPrizeRedeemed.getCity());
            recruitingJoiner.add("<b>State: </b>"+newPrizeRedeemed.getState());
            recruitingJoiner.add("<b>Zipcode: </b>"+newPrizeRedeemed.getZipcode());
        }
        else{
            recruitingJoiner.add("<b>This prize is expected to be picked up at Varen HQ</b>");
        }




        recruitingHelper.setText(recruitingJoiner.toString(), true);
        recruitingHelper.setSubject("LEAD THE WAY - New Prize Redeemed");
        mailSender.send(recruitingHelper.getMimeMessage());

        MimeMessage userMessage = mailSender.createMimeMessage();
        MimeMessageHelper userHelper = new MimeMessageHelper(userMessage);
        StringJoiner userJoiner = new StringJoiner("<br>");
        userJoiner.add("<b>Congratulations! You have successfully redeemed a prize!</b>");
        userJoiner.add("");
        userJoiner.merge(recruitingJoiner);
        userJoiner.add("");
        userJoiner.add("If you see any mistakes in the details above, please contact HR");
        userHelper.setTo(employee.getVarenEmail());
        userHelper.setSubject("LEAD THE WAY - Prize Redeemed!");
        userHelper.setText(userJoiner.toString(), true);
        mailSender.send(userHelper.getMimeMessage());






        return prizeService.addNewPrize(dateRedeemed, userId, prizeLevel, prizeName);


    }
}
