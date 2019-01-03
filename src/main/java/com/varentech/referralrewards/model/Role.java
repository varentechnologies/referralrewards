package com.varentech.referralrewards.model;

import java.util.Objects;

public class Role {

    private String roleName;
    private int roleId;

    public Role(){}

    public Role(String role){
        this.roleName = role;
    }

    public boolean equals(Object o){
        if (this == o) return true;
        if (!(o instanceof Role)) return false;
        Role otherRole = (Role) o;
        return this.roleName.equals(otherRole.getRoleName());
    }

    public int hashCode(){
        return Objects.hash(roleName);
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
