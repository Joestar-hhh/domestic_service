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

    @RequestMapping("hello")
    public String hello(){
        return "hello---";
    }
}
