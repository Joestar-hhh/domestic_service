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
    public String queryCompany(HttpServletResponse response, HttpServletRequest request, Company company, String page, String limit, String region) {
        ResultData resultData = companyManageService.queryCompany(company, Integer.parseInt(page), Integer.parseInt(limit), region);
        return JSON.toJSONString(resultData);
    }


    @ResponseBody
    @RequestMapping(value = "/checkJoin")
    public String checkJion(HttpServletRequest request, HttpServletResponse response, Company company) {
        System.out.println("checkJoin------------" + company.toString());
        ResultData resultData = companyManageService.checkJoin(company);
        return JSON.toJSONString(resultData);
    }

    @ResponseBody
    @RequestMapping(value = "/queryCompanyByService")
    public String queryCompanyByService(Company company, int page, int limit, String serviceId, String typeId) {
        ResultData resultData = companyManageService.queryCompanyByService(company, page, limit, serviceId, typeId);
        return JSON.toJSONString(resultData);
    }

    @ResponseBody
    @RequestMapping(value = "/queryCompanyByServiceType")
    public String queryCompanyByServiceType(Company company, int page, int limit, String serviceId) {
        ResultData resultData = companyManageService.queryCompanyByServiceType(company, page, limit, serviceId);
        return JSON.toJSONString(resultData);
    }

    @RequestMapping(value = "/queryCompanyOrderNum")
    public String queryCompanyOrderNum(HttpServletRequest request, HttpServletResponse response, String companyId) {
        Company company = companyManageService.queryCompanyOrderNum(Integer.parseInt(companyId));
        return JSON.toJSONString(company);
    }

}
