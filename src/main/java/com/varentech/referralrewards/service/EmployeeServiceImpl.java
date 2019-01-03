package com.varentech.referralrewards.service;

import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Role;
import com.varentech.referralrewards.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    public Employee findByUsername(String username) {
        return employeeRepository.findByUsername(username);

    }

    public List<Role> getRolesByEmail(String email){

        return employeeRepository.getRolesByEmail(email);
    }

    public Employee findByEmail(String email){
        return employeeRepository.findByEmail(email);
    }

    public Employee findByActiveDirectoryGuid(String guid){return employeeRepository.findByActiveDirectoryGuid(guid);}

    public Employee addEmployee(Employee employee){
       return employeeRepository.add(employee);
    }


}
