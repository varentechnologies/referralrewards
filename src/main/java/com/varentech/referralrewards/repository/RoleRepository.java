package com.varentech.referralrewards.repository;

import java.util.List;
import java.util.LongSummaryStatistics;

public interface RoleRepository {

    List<String> getAllRoleNames();
    List<String> getGrantableRoles(Long employeeId);
    Long getHighestAuthority(Long employeeId);
    boolean grantRole(Long employeeId, String role);
    boolean revokeRole(Long employeeId, String role);
}
