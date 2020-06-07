package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.service.ServiceTypeService;

import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/serviceTypeContrller")
public class ServiceTypeContrller {

    @Autowired
    private ServiceTypeService serviceTypeService;


    @RequestMapping("/selectServiceType")
    public String selectServiceType(HttpServletRequest request, HttpServletResponse response, ServiceType serviceType, String page, String limit) {
        System.out.println("page-----------:"+page+"    ---------:"+ Integer.parseInt(limit));
        ResultData resultData = serviceTypeService.selectList(serviceType, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/addServiceType")
    public String addServiceType(HttpServletRequest request, HttpServletResponse response, ServiceType serviceType) {

        System.out.println("admin-----------"+serviceType);
        int res=serviceTypeService.addServiceType(serviceType);
    return String.valueOf(res);
    }


    @RequestMapping("/updateServiceType")
    public String updateServiceType(HttpServletRequest request, HttpServletResponse response, ServiceType serviceType) {
        int res=serviceTypeService.updateServiceType(serviceType);
        return String.valueOf(res);
    }


    @RequestMapping("/deleteServiceType")
    public String deleteServiceType(HttpServletRequest request, HttpServletResponse response, String id) {
        System.out.println("id"+id);
        int res=serviceTypeService.deleteServiceType(Integer.parseInt(id));

        return String.valueOf(res);
    }

}