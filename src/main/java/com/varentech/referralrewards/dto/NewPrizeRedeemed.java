package com.varentech.referralrewards.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.StringJoiner;

public class NewPrizeRedeemed {

    private String prizeLevel;
    private String dateRedeemed;
    private String prizeName;

    private String manageremail;
    private String streetaddress;
    private String city;
    private String state;
    private String zipcode;

    public String getPrizeLevel() {
        return prizeLevel;
    }

    public void setPrizeLevel(String prizeLevel) {
        this.prizeLevel = prizeLevel;
    }

    public String getDateRedeemed() {
        Date date = new Date(Instant.now().toEpochMilli());
        String modifiedDate= new SimpleDateFormat("yyyy-MM-dd").format(date);
        return modifiedDate;
    }

    public void setDateRedeemed(String dateRedeemed) {
        this.dateRedeemed = dateRedeemed;
    }

    public String getPrizeName() {
        return prizeName;
    }

    public void setPrizeName(String prizeName) {
        this.prizeName = prizeName;
    }

    public String getManageremail() {
        return manageremail;
    }

    public void setManageremail(String manageremail) {
        this.manageremail = manageremail;
    }

    public String getStreetaddress() {
        return streetaddress;
    }

    public void setStreetaddress(String streetaddress) {
        this.streetaddress = streetaddress;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String toString(){
        StringJoiner joiner = new StringJoiner("\n");
        joiner.add("Prize Level: "+prizeLevel);
        joiner.add("Date Redeemed: "+dateRedeemed);
        joiner.add("Prize Name: "+prizeName);
        joiner.add("street address: "+streetaddress);
        joiner.add("state: "+state);
        joiner.add("zip: "+zipcode);
        joiner.add("city: "+city);
        joiner.add("manager email: "+manageremail);
        return joiner.toString();
    }
}
