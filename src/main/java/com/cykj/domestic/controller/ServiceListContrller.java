package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.service.ServiceTypeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/serviceListContrller")
public class ServiceListContrller {

    @Autowired
    private ServiceListService serviceListService;


    @RequestMapping("/selectServiceList")
    public String selectServiceList(HttpServletRequest request, HttpServletResponse response, TbService tbService, String page, String limit) {
        System.out.println("page-----------:"+page+"    ---------:"+ Integer.parseInt(limit));
        ResultData resultData = serviceListService.selectList(tbService, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/addServiceList")
    public String addServiceList(HttpServletRequest request, HttpServletResponse response, TbService tbService) {

        System.out.println("admin-----------"+tbService);
        int res=serviceListService.addServicelist(tbService);
    return String.valueOf(res);
    }


    @RequestMapping("/updateServiceList")
    public String updateServiceType(HttpServletRequest request, HttpServletResponse response, TbService tbService) {
        int res=serviceListService.updateServiceList(tbService);
        return String.valueOf(res);
    }


    @RequestMapping("/deleteServiceList")
    public String deleteServiceType(HttpServletRequest request, HttpServletResponse response, String id) {
        System.out.println("id"+id);
        int res=serviceListService.deleteServiceList(Integer.parseInt(id));

        return String.valueOf(res);
    }

}
