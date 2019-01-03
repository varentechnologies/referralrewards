package com.varentech.referralrewards.repository;

import com.varentech.referralrewards.dto.EmployeeRoleQuery;
import com.varentech.referralrewards.dto.EmployeeRoleQueryResponse;
import com.varentech.referralrewards.model.Employee;
import com.varentech.referralrewards.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public class EmployeeRepositoryImpl implements EmployeeRepository {

    @Autowired
    private JdbcTemplate template;

    @Autowired
    private NamedParameterJdbcTemplate namedTemplate;

    public Employee findByUsername(String username){
        List<Employee> results = template.query("SELECT * FROM employeestats WHERE UPPER(username) = UPPER(?)", new Object[]{username}, new BeanPropertyRowMapper(Employee.class));
        return results.isEmpty() ? null : results.get(0);
    }


    public List<Role> getRolesByEmail(String email){
        return template.query("SELECT cr.roleName, cr.roleId FROM employee_role er INNER JOIN employeestats es ON er.employee_id = es.id INNER JOIN createroles cr ON er.role_id = cr.roleId WHERE UPPER(varenEmail)=UPPER(?)", new Object[]{email}, new BeanPropertyRowMapper(Role.class));
    }

    public Employee findByEmail(String email){
        List<Employee> results = template.query("SELECT * FROM employeestats WHERE UPPER(varenEmail) = UPPER(?) ", new Object[]{email}, new BeanPropertyRowMapper(Employee.class));
        return results.isEmpty() ? null : results.get(0);
    }

    public Employee findByActiveDirectoryGuid(String guid){
        return template.queryForObject("SELECT * FROM employeestats WHERE activeDirectoryGuid = ?",new Object[]{guid}, Employee.class);
    }

    public Employee add(Employee employee){
        template.update("INSERT INTO employeestats (firstName,lastName,varenEmail,password) VALUES(?,?,?,?)", employee.getFirstName(),employee.getLastName(),employee.getVarenEmail(),employee.getPassword());
        return findByEmail(employee.getVarenEmail());
    }

    public Employee findById(long id){
        List<Employee> results = template.query("SELECT * FROM employeestats WHERE id = ?", new Object[]{id}, new BeanPropertyRowMapper<>(Employee.class));
        return results.isEmpty() ? null : results.get(0);
    }

    public EmployeeRoleQueryResponse getEmployeeRolePage(EmployeeRoleQuery query, int pageSize){

        EmployeeRoleQueryResponse response = new EmployeeRoleQueryResponse();

        String sql = "SELECT es.id, es.firstName,es.lastName,es.varenEmail FROM employeestats es";
        String countQuery = "SELECT COUNT(*) FROM employeestats es";

        MapSqlParameterSource parameters = new MapSqlParameterSource();
        List<String> predicates = new LinkedList<>();

        List<String> orderby = new LinkedList<>();
        orderby.add("es.firstName");
        orderby.add("es.lastName");


        if(!query.getRoles().isEmpty()){
            String roleSubQuery = " INNER JOIN (SELECT es.id,es.firstName,es.lastName,es.varenEmail,count(es.id) AS role_match FROM employeestats es INNER JOIN employee_role er ON es.id = er.employee_id INNER JOIN createroles cr ON er.role_id = cr.roleId WHERE cr.roleName IN(";
            StringJoiner joiner = new StringJoiner(",");

            for(String s: query.getRoles()){
                joiner.add("'"+s+"'");
            }
            roleSubQuery += joiner.toString()+") GROUP BY es.id) sub_query ON es.id = sub_query.id";
            countQuery += roleSubQuery;
            sql += roleSubQuery;
            predicates.add("sub_query.role_match = "+query.getRoles().size());
        }
        String namePredicate = "";
        if(query.getFirstname().length() > 0){
            namePredicate += "UPPER(es.firstName) LIKE :firstname";
            parameters.addValue("firstname","%"+query.getFirstname().toUpperCase().trim()+"%");
        }
        if(query.getLastname().length() > 0){
            if(namePredicate.length() > 0) namePredicate += " OR ";
            namePredicate += "UPPER(es.lastName) LIKE :lastname";
            parameters.addValue("lastname","%"+query.getLastname().toUpperCase().trim()+"%");
        }

        if(namePredicate.length() > 0) predicates.add("("+namePredicate+")");

        if(query.getEmail().length() > 0){
            predicates.add("UPPER(es.varenEmail) LIKE :email");
            parameters.addValue("email", "%"+query.getEmail().toUpperCase().trim()+"%");
        }



        if(!predicates.isEmpty()){
            String whereClause = " WHERE ";

            StringJoiner joiner = new StringJoiner(" AND ");
            for(String predicate: predicates){
                joiner.add(predicate);
            }
            whereClause += joiner.toString();

            countQuery += whereClause;
            sql += whereClause;
        }

        if(!orderby.isEmpty()){
            String orderByClause = " ORDER BY ";
            StringJoiner joiner = new StringJoiner(",");
            for(String o: orderby){
                joiner.add(o);
            }
            orderByClause += joiner.toString();

            sql += orderByClause;
        }

        sql += " LIMIT :offset,:pagesize";
        parameters.addValue("offset",(query.getPage() - 1) * pageSize);
        parameters.addValue("pagesize", pageSize);





        int numRows = namedTemplate.queryForObject(countQuery,parameters,Integer.class);


        List<Employee> results = namedTemplate.query(sql,parameters,new BeanPropertyRowMapper<>(Employee.class));


        //No Results, no need to further query
        if(results.isEmpty()){
            response.setEmployees(new ArrayList<>());
            response.setTotalPages(1);
            response.setCurrentPage(query.getPage());
            return response;
        }



        StringJoiner idJoiner = new StringJoiner(",");
        for(Employee e: results){
            idJoiner.add("'" + e.getId() +"'");
        }

        String idString = idJoiner.toString();



        //Joins results of employee ids with role table to retrieve the roles each employee has
        String roleSql = "SELECT es.id as e_id, es.firstName, es.lastName, es.varenEmail, cr.roleName FROM employeestats es LEFT JOIN employee_role er ON es.id = er.employee_id LEFT JOIN createroles cr ON er.role_id = cr.roleId";
        roleSql += " WHERE es.id IN (" + idString + ") ORDER BY es.firstName, es.lastName" ;


        List<Map<String,Object>> rows = template.queryForList(roleSql);




        Map<Long,Employee> employeeMap = new LinkedHashMap<>();
        for(Map row: rows){
            Long id = (Long) row.get("e_id");
            String firstname = (String)row.get("firstName");
            String lastname = (String)row.get("lastname");
            String email = (String)row.get("varenEmail");
            String role = (String)row.get("roleName");

            if(!employeeMap.containsKey(id)){
                Employee toAdd = new Employee();
                toAdd.setId(id);
                toAdd.setFirstName(firstname);
                toAdd.setLastName(lastname);
                toAdd.setVarenEmail(email);

                employeeMap.put(id,toAdd);

            }

            Employee employee = employeeMap.get(id);
            if(role != null) { //Since we did LEFT JOIN to include employees without any roles in employee_role table, we need to make sure this is not null
                employee.getAuthorities().add(role);
            }
        }


        List<Employee> employees = new LinkedList<>(employeeMap.values());


        response.setEmployees(employees);
        response.setTotalPages((int)Math.ceil((double)numRows / pageSize));
        response.setCurrentPage(query.getPage());

        return response;




    }
}
