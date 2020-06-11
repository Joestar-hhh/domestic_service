package com.cykj.domestic.service;

import com.cykj.domestic.entity.Role;
import com.cykj.domestic.util.ResultData;

import java.util.List;

public interface RoleService {

    ResultData queryRoleInfo(Role role, int page, int limit);

    ResultData insertRole(Role role);

    ResultData updateRole(Role role);

    ResultData deleteRole(String idList);

    ResultData queryAllRole();
}
