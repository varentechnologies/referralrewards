package com.varentech.referralrewards.model;

public class LeaderboardInfoModel {

private long id;
private String firstName;
private String lastName;
private Integer pointsThisYear;
private Integer pointsThisMonth;

public long getId(){
    return id;
}
public String getFirstName(){
    return firstName;
}
public String getLastName(){
    return lastName;
}
public Integer getPointsThisYear(){
    return pointsThisYear;
}
public Integer getPointsThisMonth(){
    return pointsThisMonth;
}

public void setId(long id){
    this.id= id;
}
public void setFirstName(String fname){
    this.firstName=fname;
}
public void setLastName(String lname){
    this.lastName=lname;
}
public void setPointsThisYear(Integer pointsYear){
    this.pointsThisYear=pointsYear;
}
public void setPointsThisMonth(Integer pointsMonth){
    this.pointsThisMonth=pointsMonth;
}

}
