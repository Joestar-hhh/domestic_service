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
    public String selectMyCompany(HttpServletRequest request, HttpServletResponse response, Company company) {
//        System.out.println("公司信息查询page的值"+page);
        Company company1 = (Company)request.getSession().getAttribute("company");
        ResultData resultData = myCompanyService.selectList(company,company1.getId());
        return JSON.toJSONString(resultData);
    }


    //修改公司数据
    @RequestMapping("/updateMycompany")
    public String updateMycompany(HttpServletRequest request, HttpServletResponse response, Company company) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        ResultData resultData=myCompanyService.updateMycompany(company,company1.getId());
        return JSON.toJSONString(resultData);
    }



    //修改公司数据
    @RequestMapping("/addCompanycollection")
    public String addCompanycollection(HttpServletRequest request, HttpServletResponse response, Company company) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        ResultData resultData=myCompanyService.updateMycompany(company,company1.getId());
        return JSON.toJSONString(resultData);
    }



////查询我的公司地址Id
//@RequestMapping("/selectAddressID")
//public String selectAddressID(HttpServletRequest request, HttpServletResponse response, Company company) {
//    ResultData resultData = myCompanyService.selectAddressDI(company);
//    //修改市县地址Id
//    ResultData resultData2=myCompanyService.updateAddressID(company.getId());
//    return JSON.toJSONString(resultData);
//}

//    //修改我的公司地址Id
//    @RequestMapping("/updateAddressID")
//    public String updateAddressID(HttpServletRequest request, HttpServletResponse response, Company company) {
//        ResultData resultData = myCompanyService.selectAddressDI(company);
//        return JSON.toJSONString(resultData);
//    }
}
