package com.varentech.referralrewards.model;

public class RecruiterInfoModel {

    private long id;
    private String lastName;
    private String firstName;
    private String clearanceLevel;
    private String referralWasMadeOn;
    private String interviewed;
    private String offer;
    private String hired;
    private String notes;
    private String futureCon;
    private boolean inPersonReferral;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getClearanceLevel() {
        return clearanceLevel;
    }

    public void setClearanceLevel(String clearanceLevel) {
        this.clearanceLevel = clearanceLevel;
    }

    public String getReferralWasMadeOn() {
        return referralWasMadeOn;
    }

    public void setReferralWasMadeOn(String referralWasMadeOn) {
        this.referralWasMadeOn = referralWasMadeOn;
    }

    public String getInterviewed() {
        return interviewed;
    }

    public void setInterviewed(String interviewed) {
        this.interviewed = interviewed;
    }

    public String getOffer() {
        return offer;
    }

    public void setOffer(String offer) {
        this.offer = offer;
    }

    public String getHired() {
        return hired;
    }

    public void setHired(String hired) {
        this.hired = hired;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
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
}