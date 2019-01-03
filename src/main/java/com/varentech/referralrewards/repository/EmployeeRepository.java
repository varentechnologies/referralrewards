package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.dto.EmployeeRoleQuery;
import com.varentech.referralrewards.dto.EmployeeRoleQueryResponse;
import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Role;

import java.util.List;

public interface EmployeeRepository {

    Employee findByUsername(String username);
    List<Role> getRolesByEmail(String email);
    Employee findByEmail(String email);
    Employee findByActiveDirectoryGuid(String guid);
    Employee add(Employee employee);
    EmployeeRoleQueryResponse getEmployeeRolePage(EmployeeRoleQuery query, int pageSize);
    Employee findById(long id);


}
