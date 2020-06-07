package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Role;
import com.cykj.domestic.service.RoleService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RestController
@RequestMapping("/roleController")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /*
    * 查询角色信息
    */
    @RequestMapping("/queryRole")
    public String queryRole(HttpServletRequest request, HttpServletResponse response,
                            Role role, String page, String limit){
        System.out.println("queryRole--------------limit:"+limit+"--------page:"+page);
        ResultData resultData =  roleService.queryRoleInfo(role, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    /*
    * 添加角色
    */
    @RequestMapping("/insertRole")
    public String insertRole(HttpServletRequest request, HttpServletResponse response, Role role){
        System.out.println("insertRole--------------role:"+role.toString());
        ResultData resultData = roleService.insertRole(role);
        return JSON.toJSONString(resultData);
    }

    /*
     * 修改角色
     */
    @RequestMapping("/updateRole")
    public String updateRole(HttpServletRequest request, HttpServletResponse response, Role role){
        System.out.println("updateRole--------------role:"+role.toString());
        ResultData resultData = roleService.updateRole(role);
        return JSON.toJSONString(resultData);
    }

    /*
     * 删除角色
     */
    @RequestMapping("/deleteRole")
    public String deleteRole(HttpServletRequest request, HttpServletResponse response, String idList){
        System.out.println("updateRole--------------idList:"+idList);
        ResultData resultData = roleService.deleteRole(idList);
        return JSON.toJSONString(resultData);
    }
}
