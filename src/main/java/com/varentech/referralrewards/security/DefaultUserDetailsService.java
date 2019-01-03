package com.varentech.referralrewards.security;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Role;
import com.varentech.referralrewards.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("DefaultUserDetailsService")
public class DefaultUserDetailsService implements UserDetailsService {

    @Autowired
    private EmployeeService employeeService;



    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String email) {

        Employee employee = employeeService.findByEmail(email);

        if (employee != null) {

            List<Role> roles = employeeService.getRolesByEmail(employee.getVarenEmail());
            List<GrantedAuthority> grantedAuthorities = new ArrayList<>();

            for (Role r : roles) {
                grantedAuthorities.add(new SimpleGrantedAuthority(r.getRoleName()));
            }
            return new DefaultUser(employee.getId(), employee.getVarenEmail(), employee.getPassword(),employee.getFirstName(),employee.getLastName(), grantedAuthorities);
        } else {

            throw new UsernameNotFoundException("Username not found");
        }
    }
}
