package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.MyCompanyService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/myCompanyContrller")
public class MyCompanyContrller {

    @Autowired
    private MyCompanyService myCompanyService;

//查询所有服务列表数据
    @RequestMapping("/selectMyCompany")
    public String selectMyCompany(HttpServletRequest request, Company company) {
//        System.out.println("公司信息查询page的值"+page);
        Company company1 = (Company)request.getSession().getAttribute("company");
        ResultData resultData = myCompanyService.selectList(company,company1.getId());
        return JSON.toJSONString(resultData);
    }


    //修改公司数据
    @RequestMapping("/updateMycompany")
    public String updateMycompany(HttpServletRequest request,String CityLevel,String CountyLevel, Company company) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        company.setId(company1.getId());
        System.out.println("-----------CountyLevel:"+CountyLevel);
        company.setFirstLevelRegion(CityLevel);
        company.setSecondaryZone(CountyLevel);
        ResultData resultData=myCompanyService.updateMycompany(company);
        return JSON.toJSONString(resultData);
    }

//    //修改公司服务信息
//    @RequestMapping("/addCompanycollection")
//    public String addCompanycollection(HttpServletRequest request, HttpServletResponse response, Company company) {
//        Company company1 = (Company)request.getSession().getAttribute("company");
//        ResultData resultData=myCompanyService.addCompanycollection(company,company1.getId());
//        return JSON.toJSONString(resultData);
//    }

}
