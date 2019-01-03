package com.varentech.referralrewards.dto;

import java.util.List;

public class EmployeeRoleQuery {

    private String firstname;
    private String lastname;
    private String email;
    private List<String> roles;
    private int page;

    public EmployeeRoleQuery(){}

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public List<String> getRoles() {
        return roles;
    }

    public void setRoles(List<String> roles) {
        this.roles = roles;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String toString(){
        StringBuilder builder = new StringBuilder();
        return builder.append(firstname).append(lastname).append(email).append(roles).append(page).toString();
    }
}
