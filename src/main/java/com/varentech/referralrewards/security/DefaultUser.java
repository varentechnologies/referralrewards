package com.varentech.referralrewards.security;

import org.springframework.context.annotation.Bean;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class DefaultUser extends User implements UserDetails {

    private Long id;
    private String firstname;
    private String lastname;

    public DefaultUser(Long id, String email, String password, String firstname, String lastname,Collection<? extends GrantedAuthority> authorities){
        super(email,password,authorities);
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
    }

    public DefaultUser(String username){
        super(username,"",new ArrayList<GrantedAuthority>());
    }

    public DefaultUser(String username, Collection<? extends GrantedAuthority> authorities){
        super(username,"",authorities);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

}
