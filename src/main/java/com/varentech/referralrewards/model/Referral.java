package com.varentech.referralrewards.model;

import com.varentech.referralrewards.security.DefaultUser;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.multipart.MultipartFile;


import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.time.LocalDate;


public class Referral {

    private Integer id;
    private String submitDate;
    private String lastName;
    private String firstName;
    private String clearanceLevel;
    private String candidateEmail;
    private String candidatePhone;
    private String possiblePosition;
    private String knownBy;
    private String qualifications;
    private String empemail;
    private String emplastname;
    private String empfirstname;
    private Integer employeeId;
    private String anon;
    private String resume;
    private Date referralWasMadeOn;
    private Date interviewed;
    private Date offer;
    private Date hired;
    private String notes;
    private Integer status = 0;
    private String comment;
  //  private MultipartFile file;

/*
    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }*/

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }
    public void setLastName(String candidatelastname) {
        this.lastName = candidatelastname;
    }

    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String candidatefirstname) {
        this.firstName = candidatefirstname;
    }

    public String getCandidateEmail() {
        return candidateEmail;
    }
    public void setCandidateEmail(String email) {
        this.candidateEmail = email;
    }

    public String getCandidatePhone() {
        return candidatePhone;
    }
    public void setCandidatePhone(String candidatePhone) {
        this.candidatePhone = candidatePhone;
    }
    public String getClearanceLevel() {
        return clearanceLevel;
    }
    public void setClearanceLevel(String clearance) {
        this.clearanceLevel = clearance;
    }

    public String getPossiblePosition() {
        return possiblePosition;
    }
    public void setPossiblePosition(String position) { this.possiblePosition = position; }

    public String getKnownBy() {
        return knownBy;
    }
    public void setKnownBy(String relation) {
        this.knownBy = relation;
    }

    public String getQualifications() {
        return qualifications;
    }
    public void setQualifications(String qualification) {
        this.qualifications = qualification;
    }

    public String getResume() {
        return resume;
    }
    public void setResume(String resume) {
        this.resume = resume;
    }

    public String getEmpemail() {
        return empemail;
    }
    public void setEmpemail(String empemail) {
        this.empemail = empemail;
    }

    public String getAnon() {
        return anon;
    }
    public void setAnon(String anonymous) {
        this.anon = anonymous;
    }

    public String getSubmitDate() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDate localDate = LocalDate.now();
        return dtf.format(localDate);
    }
    public void setSubmitDate(String submitDate){this.submitDate = submitDate; }

    public Date getReferralWasMadeOn(){return referralWasMadeOn;}
    public void setReferralWasMadeOn(Date referralWasMadeOn){this.referralWasMadeOn = referralWasMadeOn;}

    public Date getOffer(){return offer;}
    public void setOffer(Date offer){this.offer = offer;}

    public Date getHired(){return hired;}
    public void setHired(Date hired) {
        this.hired = hired;
    }

    public Date getInterviewed(){return interviewed;}
    public void setInterviewed(Date interviewed){this.interviewed = interviewed;}

    public String getNotes(){return notes;}
    public void setNotes(String notes){this.notes = notes;}

    public Integer getStatus(){return status;}
    public void setStatus(Integer status){this.status = status;}

    public Integer getEmployeeId(){
       return this.employeeId;
       }
    public void setEmployeeId(Integer employeeId){
        this.employeeId=employeeId;
    }

    public String getEmplastname() {
        return emplastname;
    }

    public void setEmplastname(String emplastname) {
        this.emplastname = emplastname;
    }

    public String getEmpfirstname() {
        return empfirstname;
    }

    public void setEmpfirstname(String empfirstname) {
        this.empfirstname = empfirstname;
    }

    public String toString() {
        return "Id No: " + id + ";" + " Cand. Last Name: " + lastName + ";" + " Cand. First Name: " + firstName + ";" + " Email: " + candidateEmail + ";" +
                " Phone Number: " + candidatePhone + ";" + " Clearance Level: " + clearanceLevel + ";" + " Position Referred For: " + possiblePosition + ";" + " Relation to Candidate: " + knownBy + ";" +
                " Qualification: " + qualifications + ";" + " Resume: " + resume + ";"  +
                " Emp. Email: " + empemail + ";" + " Anonymous? " + anon + "Employee Id:" +employeeId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }


}
