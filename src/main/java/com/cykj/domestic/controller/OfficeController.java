package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.service.OfficeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/officeController")
public class OfficeController {

    @Autowired
    private OfficeService officeService;

    //查询顾问管理信息--
    @RequestMapping("/queryOfficeList")
    public String queryOffice(HttpServletRequest request, HttpServletResponse response,
                              Staff staff, String page, String limit) {
        ResultData resultData = officeService.queryOfficeList(staff, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    // 删除培训计划
    @RequestMapping("/deleteOffice")
    public String deleteOffice(HttpServletRequest request, HttpServletResponse response) {
        String officeid = request.getParameter("id");
        int id = Integer.parseInt(officeid);
        ResultData resultData = officeService.deleteOffice(id);
        return JSON.toJSONString(resultData);
    }

    // 修改培训计划
    @RequestMapping("/updateOffice")
    public String updateOffice(HttpServletRequest request, HttpServletResponse response, Staff staff) {
        ResultData resultData = officeService.updateOffice(staff);
        return JSON.toJSONString(resultData);
    }

    // 增加培训计划
    @RequestMapping("/insertOffice")
    public String insertOffice(HttpServletRequest request, HttpServletResponse response, Staff staff) {
        ResultData resultData = officeService.insertOffice(staff);
        return JSON.toJSONString(resultData);
    }

    //下拉框列表
    @RequestMapping("/counselorList")
    public String regionList(HttpServletRequest request, HttpServletResponse response) {
        ResultData resultData = officeService.counselorList();
        return JSON.toJSONString(resultData);
    }
}
