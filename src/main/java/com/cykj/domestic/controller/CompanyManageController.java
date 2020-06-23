package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.service.CompanyManageService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/companyManageController")
public class CompanyManageController {

    @Autowired
    public CompanyManageService companyManageService;

    /*
    家政公司管理列表
     */
    @ResponseBody
    @RequestMapping(value = "/queryCompany")
    public String queryCompany(HttpServletResponse response, HttpServletRequest request, Company company, String page, String limit,String address) {
        ResultData resultData = companyManageService.queryCompany(company,Integer.parseInt(page), Integer.parseInt(limit),address);
        return JSON.toJSONString(resultData);
    }


    @ResponseBody
    @RequestMapping(value = "/checkJoin")
    public String checkJion(HttpServletRequest request, HttpServletResponse response,Company company){
        System.out.println("checkJoin------------"+company.toString());
       ResultData resultData= companyManageService.checkJoin(company);
       return JSON.toJSONString(resultData);
    }

    @ResponseBody
    @RequestMapping(value = "/queryCompanyByService")
    public String queryCompanyByService(Company company, int page, int limit, int serviceId) {
        ResultData resultData = companyManageService.queryCompanyByService(company,page,limit,serviceId);
        return JSON.toJSONString(resultData);
    }
}
