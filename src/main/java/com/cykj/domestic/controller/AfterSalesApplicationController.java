package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.AfterSalesApplication;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.service.AfterSalesApplicationService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/afterSalesApplicationController")
public class AfterSalesApplicationController {

    @Autowired
    private AfterSalesApplicationService afterSalesApplicationService;

    @RequestMapping("/queryAfterSalesApplication")
    public String queryAfterSalesApplication(HttpServletRequest request, HttpServletResponse response,
                                             AfterSalesApplication afterSalesApplication, String page, String limit, String orderNumber) {
        Company company = (Company) request.getSession().getAttribute("company");
        ResultData resultData = afterSalesApplicationService.queryAfterSalesApplication(afterSalesApplication, Integer.parseInt(page), Integer.parseInt(limit), company.getId(), orderNumber);
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/passCheck")
    public String passCheck(int id) {
        ResultData resultData = afterSalesApplicationService.passCheck(id);
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/nopassCheck")
    public String nopassCheck(int id) {
        ResultData resultData = afterSalesApplicationService.nopassCheck(id);
        return JSON.toJSONString(resultData);
    }
}
