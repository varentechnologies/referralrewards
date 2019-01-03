package com.varentech.referralrewards.service;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Role;

import java.util.List;

public interface EmployeeService {

     Employee findByUsername(String username);
     List<Role> getRolesByEmail(String email);
     Employee findByEmail(String email);
     Employee addEmployee(Employee employee);
     Employee findByActiveDirectoryGuid(String guid);
}
