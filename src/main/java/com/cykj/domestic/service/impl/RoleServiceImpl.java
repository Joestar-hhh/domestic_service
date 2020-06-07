package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Role;
import com.cykj.domestic.mapper.RoleMapper;
import com.cykj.domestic.service.RoleService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public ResultData queryRoleInfo(Role role, int page, int limit) {

        List<Role> list = roleMapper.queryRole(role,(page-1)*limit,limit);
        int count = roleMapper.queryRoleCount(role);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public int insertRole(Role role) {
        return roleMapper.insertRole(role);
    }
}
