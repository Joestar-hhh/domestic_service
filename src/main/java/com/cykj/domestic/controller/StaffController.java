package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.service.StaffService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RestController
@RequestMapping("/staffController")
public class StaffController {

    @Autowired
    private StaffService staffService;

    //查询顾问管理信息--
    @RequestMapping("/queryStaff")
    public String queryCounselor(HttpServletRequest request, HttpServletResponse response,
                                 Staff staff, String page, String limit ,String region) {
        ResultData resultData = staffService.queryStaffList(staff, Integer.parseInt(page), Integer.parseInt(limit) ,region);
        return JSON.toJSONString(resultData);
    }

    //启用
    @RequestMapping("/enableState")
    public int enableState(HttpServletRequest request, HttpServletResponse response, int id) {
        int res = staffService.enableState(id);
        return res;
    }

    //禁用
    @RequestMapping("/disableState")
    public int disableState(HttpServletRequest request, HttpServletResponse response, int id) {
        int res = staffService.disableState(id);
        return res;
    }

    //查看详情
    @RequestMapping("/checkStaff")
    public String checkStaff(HttpServletRequest request, HttpServletResponse response, int id) {
        List<Staff> list = staffService.checkStaff(id);
        return JSON.toJSONString(list);
    }

    //区域列表
    @RequestMapping("/regionList")
    public String regionList(HttpServletRequest request, HttpServletResponse response) {
        ResultData resultData = staffService.regionList();
        return JSON.toJSONString(resultData);
    }
//    用户查询
    @RequestMapping("/queryUser")
    public String queryUser(HttpServletRequest request, HttpServletResponse response,
                            User user, String page, String limit , String region) {
        ResultData resultData = staffService.queryUser(user, Integer.parseInt(page), Integer.parseInt(limit) ,region);
        return JSON.toJSONString(resultData);
    }

    //启用
    @RequestMapping("/enableUser")
    public ResultData enableUser(HttpServletRequest request, HttpServletResponse response, int id) {
        ResultData resultData = staffService.enableUser(id);
        return resultData;
    }

    //禁用
    @RequestMapping("/disableUser")
    public ResultData disableUser(HttpServletRequest request, HttpServletResponse response, int id) {
        ResultData resultData = staffService.disableUser(id);
        return resultData;
    }

//    用户统计
    @RequestMapping("/userStatistics")
    public String userStatistics(HttpServletRequest request, HttpServletResponse response) {
        String startDate= request.getParameter("startDate");
        String endDate= request.getParameter("endDate");
        List<User> list= staffService.userStatistics(startDate,endDate);
        return JSON.toJSONString(list);
    }




    /*
    * 公司端--员工信息
    */
    @RequestMapping("/queryCompanyStaffInfo")
    public String queryCompanyStaffInfo(HttpServletRequest request,Staff staff, String page, String limit) {
        Company company = (Company) request.getSession().getAttribute("company");
        System.out.println(" session中："+company);
        ResultData resultData = staffService.queryCompanyStaff(company.getId(),
                Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }
}

