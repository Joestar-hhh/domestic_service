package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.CompanyAccount;
import com.cykj.domestic.entity.Database;
import com.cykj.domestic.service.CompanyAccountService;
import com.cykj.domestic.service.DataBaseService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@RestController
@RequestMapping("/companyAccountContrller")
public class CompanyAccountContrller {

    @Autowired
    private CompanyAccountService companyAccountService;

//查询资金明细
    @RequestMapping("/selectList")
    public String selectList(HttpServletRequest request, HttpServletResponse response, CompanyAccount companyAccount, String page, String limit) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        System.out.println("账户明细模糊传的条件"+JSON.toJSONString(companyAccount));
        ResultData resultData = companyAccountService.selectList(companyAccount, Integer.parseInt(page), Integer.parseInt(limit),company1.getId());
        return JSON.toJSONString(resultData);
    }


    //查询
    @RequestMapping("/selectbalance")
    public String selectbalance(HttpServletRequest request, HttpServletResponse response, CompanyAccount companyAccount) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        ResultData resultData = companyAccountService.selectbalance(companyAccount,company1.getId());
        return JSON.toJSONString(resultData);
    }
}
