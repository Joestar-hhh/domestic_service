package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
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
    public ResultData insertRole(Role role) {
        int res = roleMapper.insertRole(role);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;
    }

    @Override
    public ResultData updateRole(Role role) {
        int res = roleMapper.updateRole(role);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }

    @Override
    public ResultData deleteRole(String idList) {
        List<String> list = JSON.parseArray(idList,String.class);
        int res = roleMapper.deleteRole(list);
        ResultData resultData = new ResultData();
        if(res>=1){
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }

    @Override
    public ResultData queryAllRole() {
        List<Role> list = roleMapper.queryAllRole();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }
}
