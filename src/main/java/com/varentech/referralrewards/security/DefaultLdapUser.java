package com.varentech.referralrewards.security;

import org.springframework.security.ldap.userdetails.LdapUserDetailsImpl;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DefaultLdapUser extends LdapUserDetailsImpl {

    private String fullname;
    private String firstname;
    private String lastname;
    private String email;

    public DefaultLdapUser(String fullname, String email){
        super();
        this.fullname = fullname;
        this.email = email;


        Pattern pattern = Pattern.compile("^([^ ,]+)[, ]+([^ ,]+)$");
        Matcher m = pattern.matcher(fullname);
        if(m.matches()){
            this.lastname = m.group(1);
            this.firstname = m.group(2);
        }

    }

    public String getDisplayName() {
        return fullname;
    }

    public void setDisplayName(String fullname) {
        this.fullname = fullname;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
