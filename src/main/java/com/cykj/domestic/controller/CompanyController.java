package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.service.CompanySrevice;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/companyController")
public class CompanyController {

    @Autowired
    public CompanySrevice companySrevice;


    @ResponseBody
    @RequestMapping(value = "/queryRegion")
    public String queryRegion(HttpServletResponse response, HttpServletRequest request, String page, String limit) {
        ResultData resultData = companySrevice.queryRegion(Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }


}
