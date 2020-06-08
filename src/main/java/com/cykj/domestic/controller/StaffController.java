package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Counselor;
import com.cykj.domestic.entity.Region;
import com.cykj.domestic.entity.Staff;
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

//    //根据区域查询数据
//    @RequestMapping("/queryRegion")
//    public String queryRegion(HttpServletRequest request, HttpServletResponse response,
//                              Staff staff, String page, String limit, String region) {
//        ResultData resultData = staffService.queryRegion(staff, Integer.parseInt(page), Integer.parseInt(limit), region);
//        System.out.println("查询：" + JSON.toJSONString(resultData));
//        return JSON.toJSONString(resultData);
//    }
}
