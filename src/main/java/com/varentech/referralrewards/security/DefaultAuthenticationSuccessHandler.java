package com.varentech.referralrewards.security;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Role;
import com.varentech.referralrewards.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service("DefaultAuthenticationSuccessHandler")
public class DefaultAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Autowired
    private EmployeeService employeeService;



    @Value("${authentication.mode}")
    private String authenticationMode;




    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if(authenticationMode.equals("active_directory")) {
            DefaultUser userDetails = (DefaultUser) authentication.getPrincipal();



            Employee employee = employeeService.findByEmail(userDetails.getUsername());
            if (employee == null) {

                employee = new Employee();
                employee.setFirstName(userDetails.getFirstname());
                employee.setLastName(userDetails.getLastname());
                employee.setVarenEmail(userDetails.getUsername());
                employee.setPassword(passwordEncoder.encode(authentication.getCredentials().toString()));
                employee = employeeService.addEmployee(employee);
                }
                userDetails.setId(employee.getId());
            }

        super.onAuthenticationSuccess(request,response,authentication);




}
}
