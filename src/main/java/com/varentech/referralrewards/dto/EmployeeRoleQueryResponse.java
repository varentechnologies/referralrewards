package com.varentech.referralrewards.dto;

import com.varentech.referralrewards.model.Employee;

import java.util.List;

public class EmployeeRoleQueryResponse {


    private List<Employee> employees;
    private int currentPage;
    private int totalPages;
    private List<String> allRoles;
    private List<String> grantableRoles;

    public List<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Employee> employees) {
        this.employees = employees;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public List<String> getAllRoles() {
        return allRoles;
    }

    public void setAllRoles(List<String> allRoles) {
        this.allRoles = allRoles;
    }

    public List<String> getGrantableRoles() {
        return grantableRoles;
    }

    public void setGrantableRoles(List<String> grantableRoles) {
        this.grantableRoles = grantableRoles;
    }
}
