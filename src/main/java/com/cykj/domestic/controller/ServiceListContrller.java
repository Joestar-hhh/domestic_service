package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.ServiceListService;
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

//查询所有服务列表数据
    @RequestMapping("/selectServiceList")
    public String selectServiceList(HttpServletRequest request, HttpServletResponse response, TbService tbService, String page, String limit) {
        ResultData resultData = serviceListService.selectList(tbService, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

//添加服务列表数据
    @RequestMapping("/addServiceList")
    public String addServiceList(HttpServletRequest request, HttpServletResponse response, TbService tbService) {
        ResultData resultData=serviceListService.addServicelist(tbService);
    return JSON.toJSONString(resultData);
    }


    //修改服务列表数据
    @RequestMapping("/updateServiceList")
    public String updateServiceType(HttpServletRequest request, HttpServletResponse response, TbService tbService) {
        ResultData resultData=serviceListService.updateServiceList(tbService);
        return JSON.toJSONString(resultData);
    }


    //删除服务列表数据
    @RequestMapping("/deleteServiceList")
    public String deleteServiceType(HttpServletRequest request, HttpServletResponse response,int id) {
        ResultData resultData=serviceListService.deleteServiceList(id);
        return JSON.toJSONString(resultData);
    }

    //查询所有服务类型
   @RequestMapping("/selectService")
    public String selectService(HttpServletRequest request, HttpServletResponse response) {
        ResultData resultData = serviceListService.selectService();
        return JSON.toJSONString(resultData);
    }


    //查询详情
    @RequestMapping("/serviceListView")
    public String serviceListView(HttpServletRequest request, HttpServletResponse response,int id) {
        ResultData resultData = serviceListService.serviceListView(id);
        return JSON.toJSONString(resultData);
    }

    //查询所有服务和服务类别
    @RequestMapping("/queryServiceTypeName")
    public String queryServiceTypeName(HttpServletRequest request, HttpServletResponse response,String page, String limit){
       Company company= (Company) request.getSession().getAttribute("company");
        ResultData resultData = serviceListService.queryServiceTypeName(company.getId(),Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }




}
