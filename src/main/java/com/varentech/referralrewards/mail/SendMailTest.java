package com.varentech.referralrewards.mail;

public class SendMailTest {
    public static void main (String[] args){
        String from = "c.orndorff09@gmail.com";
        String to = "c.orndorff09@gmail.com";
        String subject = "Message from User";
        String message = "Test";

        SendMail sendMail = new SendMail(from, to, subject, message);
        sendMail.send();
    }
}
