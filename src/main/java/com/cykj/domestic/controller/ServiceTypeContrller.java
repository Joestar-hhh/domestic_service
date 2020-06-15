package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.service.ServiceTypeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/serviceTypeContrller")
public class ServiceTypeContrller {

    @Autowired
    private ServiceTypeService serviceTypeService;


    @RequestMapping("/selectServiceType")
    public String selectServiceType(HttpServletRequest request, HttpServletResponse response, ServiceType serviceType, String page, String limit) {
        ResultData resultData = serviceTypeService.selectList(serviceType, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/addServiceType")
    public String addServiceType(HttpServletRequest request, HttpServletResponse response, ServiceType serviceType) {
        ResultData resultData = serviceTypeService.addServiceType(serviceType);
        return JSON.toJSONString(resultData);
    }


    @RequestMapping("/updateServiceType")
    public String updateServiceType(HttpServletRequest request, HttpServletResponse response, ServiceType serviceType) {
        ResultData resultData = serviceTypeService.updateServiceType(serviceType);
        return JSON.toJSONString(resultData);
    }


    @RequestMapping("/deleteServiceType")
    public String deleteServiceType(HttpServletRequest request, HttpServletResponse response, String id) {
        ResultData resultData = serviceTypeService.deleteServiceType(Integer.parseInt(id));

        return JSON.toJSONString(resultData);
    }


    //查询详情
    @RequestMapping("/serviceTypeView")
    public String serviceListView(HttpServletRequest request, HttpServletResponse response, int id) {
        ResultData resultData = serviceTypeService.serviceTypeView(id);
        return JSON.toJSONString(resultData);
    }

    /*公司端服务类别查询*/
    @RequestMapping("/queryCompanyServiceType")
    public String queryCompanyServiceType(HttpServletResponse response, HttpServletRequest request, String page, String limit, HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        ResultData resultData = serviceTypeService.queryCompanyServiceType(String.valueOf(company.getId()), Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    /*公司申请添加服务类别关系*/
    @RequestMapping("/addServicerelstion")
    public String addServicerelstion(HttpServletResponse response, HttpServletRequest request, String id, HttpSession session) {
        Company company = (Company) session.getAttribute("company");
        ServiceType serviceType = new ServiceType();
        serviceType.setCompanyId(company.getId());
        serviceType.setId(Integer.parseInt(id));
        serviceType.setState("未审核");
        ResultData resultData = serviceTypeService.addServicerelstion(serviceType);
        return JSON.toJSONString(resultData);
    }


    /*查询所有服务类别*/
    @RequestMapping("/queryServiceType")
    public String queryServiceType(HttpServletRequest request, HttpServletResponse response) {
        ResultData resultData = serviceTypeService.queryServiceType();
        return JSON.toJSONString(resultData);
    }

    /*查询平台端审核服务类别*/
    @RequestMapping("/querySericeTypeRelation")
    public String querySericeTypeRelation(HttpServletRequest request, HttpServletResponse response, ServiceType serviceType, String page, String limit) {
        ResultData resultData = serviceTypeService.querySericeTypeRelation(serviceType,Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }


    /*平台修改公司端发送的服务类别申请变 审核通过*/

    @RequestMapping("/updateSericeTypeRelation")
    public String updateSericeTypeRelation(HttpServletResponse response,HttpServletRequest request,ServiceType serviceType){
        ResultData resultData=serviceTypeService.updateSericeTypeRelation(serviceType);
        return JSON.toJSONString(resultData);
    }

    //  公司申请入驻添加服务服务类别
    @RequestMapping("/addServiceContinuous")
    public String addServiceContinuous(HttpServletResponse response,HttpServletRequest request,ServiceType serviceType,Company company1,String typridList,HttpSession session){
        Company company = (Company) session.getAttribute("company");
        ResultData resultData=serviceTypeService.addServiceContinuous(typridList,String.valueOf(company.getId()),company1);
        return JSON.toJSONString(resultData);
    }


    /*查询所有服务*/
    @RequestMapping("/selectSerice")
    public String selectSerice(HttpServletResponse response,HttpServletRequest request){
        ResultData resultData=serviceTypeService.selectSerice();
        return JSON.toJSONString(resultData);
    }
}
