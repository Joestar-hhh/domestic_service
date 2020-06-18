package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.Menu;
import com.cykj.domestic.entity.MenuData;
import com.cykj.domestic.service.MenuService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/menuController")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("/queryMenu")
    public Object queryMenu(HttpServletRequest request){
        String projectPath = request.getContextPath();
        Company company = (Company) request.getSession().getAttribute("company");
        List<Menu> menuDataList = null;
        if(company!=null){
            menuDataList = menuService.queryMenuList(String.valueOf(company.getRoleId()),projectPath);
        }
        return menuDataList;
    }

    /*
    * 权限
    */
    @RequestMapping("/permissions")
    public Object permissions(String roleId){
        List<Menu> menuDataList = menuService.queryList(roleId);
        return menuDataList;
    }

    /*
     * 保存菜单修改
     */
    @RequestMapping("/roleMenuUpdate")
    public Object roleMenuUpdate(String rolemenuList, String roleId){
        ResultData resultData = menuService.insertRoleMenu(rolemenuList,roleId);
        return JSON.toJSONString(resultData);
    }

}
