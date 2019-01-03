package com.varentech.referralrewards.security;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Role;
import com.varentech.referralrewards.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.naming.NamingException;
import javax.xml.bind.DatatypeConverter;
import java.rmi.Naming;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Service("DefaultUserDetailsContextMapper")
public class DefaultUserDetailsContextMapper implements UserDetailsContextMapper {

    @Autowired
    private EmployeeService employeeService;


    @Transactional
    public UserDetails mapUserFromContext(DirContextOperations ctx, String username, java.util.Collection<? extends GrantedAuthority> authorities) {

        String fullname = ctx.getStringAttribute("name");
        String email = ctx.getStringAttribute("userPrincipalName");

        Pattern pattern = Pattern.compile("^([^ ,]+)[, ]+([^ ,]+)$");
        Matcher m = pattern.matcher(fullname);

        String firstname, lastname;
        if(m.matches()){
            lastname = m.group(1);
            firstname = m.group(2);
        }
        else{
            throw new IllegalArgumentException("Unable to parse name from active directory");
        }

        List<Role> roles = employeeService.getRolesByEmail(email);
        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        for(Role r: roles){
            grantedAuthorities.add(new SimpleGrantedAuthority(r.getRoleName()));
        }

        DefaultUser toReturn = new DefaultUser(email, grantedAuthorities);
        toReturn.setFirstname(firstname);
        toReturn.setLastname(lastname);

        return toReturn;
    }


    public void mapUserToContext(UserDetails userDetails, DirContextAdapter dirContextAdapter) {

    }


}
