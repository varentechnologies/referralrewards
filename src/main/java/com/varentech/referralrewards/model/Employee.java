package com.varentech.referralrewards.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.LinkedHashSet;
import java.util.Set;

public class Employee {

    private Long id;
    private String firstName;
    private String lastName;

    private String varenEmail;

    @JsonIgnore
    private String password;

    private Set<String> authorities = new LinkedHashSet<>();

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }



    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }



    public String getVarenEmail() {
        return varenEmail;
    }

    public void setVarenEmail(String varenEmail) {
        this.varenEmail = varenEmail;
    }

    public Set<String> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(Set<String> authorities) {
        this.authorities = authorities;
    }
}
