package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.dto.EmployeeRoleQuery;
import com.varentech.referralrewards.dto.EmployeeRoleQueryResponse;
import com.varentech.referralrewards.repository.EmployeeRepository;
import com.varentech.referralrewards.repository.RoleRepository;
import com.varentech.referralrewards.security.DefaultUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class AdminRestController {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private RoleRepository roleRepository;

    @PostMapping(value = "/admin/employee/search", produces = "application/json; charset=UTF-8")
    public EmployeeRoleQueryResponse processQuery(@RequestBody EmployeeRoleQuery query, @AuthenticationPrincipal DefaultUser user){
        EmployeeRoleQueryResponse response = employeeRepository.getEmployeeRolePage(query,10);

        response.setAllRoles(roleRepository.getAllRoleNames());
        response.setGrantableRoles(roleRepository.getGrantableRoles(user.getId()));


        return response;
    }

    @PostMapping(value = "/admin/role/{role}/{action}/{employeeid}")
    public boolean updateRole(@PathVariable("role") String role, @PathVariable("action") String action, @PathVariable("employeeid") long employeeid, @AuthenticationPrincipal DefaultUser user){
        List<String> grantableRoles = roleRepository.getGrantableRoles(user.getId());

        if(grantableRoles.contains(role)){
            if(action.equalsIgnoreCase("grant")){
               return roleRepository.grantRole(employeeid,role);
            }
            else if(action.equalsIgnoreCase("revoke")){
                return roleRepository.revokeRole(employeeid,role);
            }
            else{
                return false;
            }

        }

        return false;
    }


}
