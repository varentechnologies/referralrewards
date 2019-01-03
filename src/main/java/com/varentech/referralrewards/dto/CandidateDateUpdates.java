package com.varentech.referralrewards.dto;

public class CandidateDateUpdates {

    private String refDate;
    private String rowIdNo;
    private String intDate;
    private String offDate;
    private String hireDate;
    private String notes;
    private Integer status;
    private String clearanceLevel;
    private String futureCon;
    private boolean inPersonReferral;

    public CandidateDateUpdates(){

    }

    public String getRefDate() {
        return refDate;
    }

    public void setRefDate(String refDate) {
        this.refDate = refDate;
    }

    public String getRowIdNo() {
        return rowIdNo;
    }

    public void setRowIdNo(String rowIdNo) {
        this.rowIdNo = rowIdNo;
    }

    public String getIntDate() {
        return intDate;
    }

    public void setIntDate(String intDate) {
        this.intDate = intDate;
    }

    public String getOffDate() {
        return offDate;
    }

    public void setOffDate(String offDate) {
        this.offDate = offDate;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
    public String getClearanceLevel() {
        return clearanceLevel;
    }

    public void setClearanceLevel(String clearanceLevel) {
        this.clearanceLevel = clearanceLevel;
    }


    public String getFutureCon() {
        return futureCon;
    }

    public void setFutureCon(String futureCon) {
        this.futureCon = futureCon;
    }

    public boolean isInPersonReferral() {
        return inPersonReferral;
    }

    public void setInPersonReferral(boolean inPersonReferral) {
        this.inPersonReferral = inPersonReferral;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        if(futureCon!=null){status=5;}
        else{
            if (hireDate==null){
             if(offDate==null){
                 if(intDate==null){
                    if (refDate==null){
                        status=1;
                    } else {status=1;}
                }else {status=2;}
            }else {status=3;}
        }else{status=4;}}

        this.status = status;
    }
}
