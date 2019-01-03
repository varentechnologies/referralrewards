package com.varentech.referralrewards.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RoleRepositoryImpl implements RoleRepository{

    @Autowired
    private JdbcTemplate template;

    public List<String> getAllRoleNames(){
        return template.queryForList("SELECT roleName FROM createroles ORDER BY roleId",String.class);
    }

    public List<String> getGrantableRoles(Long employeeId){
        /* An employee's highest authority is the role that they have that has the LOWEST id number. Lower id number = higher authority */
        Long highestAuthority = getHighestAuthority(employeeId);

        return template.queryForList("SELECT roleName FROM createroles WHERE roleId > ?", new Object[]{highestAuthority},String.class);

    }

    public Long getHighestAuthority(Long employeeId){
        return template.queryForObject("SELECT er.role_id FROM employee_role er LEFT JOIN employee_role er2 ON er.employee_id = er2.employee_id AND er.role_id > er2.role_id INNER JOIN employeestats es ON es.id = er.employee_id WHERE er2.role_id IS NULL AND es.id = ?", new Object[]{employeeId}, Long.class);
    }

    public boolean grantRole(Long employeeId, String role){
        Long roleId = getRoleId(role);
        if(roleId == null){
            return false;
        }

        template.update("INSERT INTO employee_role (role_id,employee_id) VALUES (?,?)", new Object[]{roleId,employeeId});
        return true;
    }

    public boolean revokeRole(Long employeeId, String role){
        Long roleId = getRoleId(role);
        if(roleId == null){
            return false;
        }

        template.update("DELETE FROM employee_role WHERE employee_id = ? AND role_id = ?", new Object[]{employeeId,roleId});
        return true;
    }

    public Long getRoleId(String name){
        return template.queryForObject("SELECT roleId from createroles WHERE roleName = ?", new Object[]{name}, Long.class);
    }
}
