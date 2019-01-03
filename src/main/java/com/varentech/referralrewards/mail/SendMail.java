package com.varentech.referralrewards.mail;

import java.util.Properties;

import javax.mail.*;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {

    private String from;
    private String to ;
    private String subject;
    private String text;

    public SendMail (String to, String from, String subject, String text){
        this.from = from;
        this.to = to;
        this.subject = subject;
        this.text = text;
    }

    public void send(){
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.port", "587");

        Session mailSession = Session.getDefaultInstance(props, new javax.mail.Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("c.orndorff09@gmail.com","mmatxifiqgmlbprn");
            }
        });
        Message simpleMessage = new MimeMessage(mailSession);

        InternetAddress fromAddress = null;
        InternetAddress toAddress = null;
        try{
            fromAddress = new InternetAddress(from);
            toAddress = new InternetAddress(to);
        }
        catch (AddressException e){
                e.printStackTrace();
        }
        try{
            simpleMessage.setFrom(fromAddress);
            simpleMessage.setRecipient(RecipientType.TO, toAddress);
            simpleMessage.setSubject(subject);
            simpleMessage.setText(text);
            Transport.send(simpleMessage);
        }
        catch (MessagingException e){
            e.printStackTrace();
        }
    }
}
