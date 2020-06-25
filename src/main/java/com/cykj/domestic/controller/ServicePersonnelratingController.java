package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.service.ServicePersonnelratingService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/servicePersonnelratingController")
public class ServicePersonnelratingController {

    @Autowired
    private ServicePersonnelratingService servicePersonnelratingService;

    @RequestMapping("/queryServiceEvaluationList")
    public String queryServiceEvaluationList(HttpServletRequest request, HttpServletResponse response,
                                             PersonnelRating personnelRating, String page, String limit) {
        Company company = (Company) request.getSession().getAttribute("company");
        ResultData resultData = servicePersonnelratingService.queryServiceEvaluationList(personnelRating, Integer.parseInt(page), Integer.parseInt(limit), company.getId());
        return JSON.toJSONString(resultData);
    }

    //查询详情
    @RequestMapping("/serviceListView")
    public String serviceListView(HttpServletRequest request, HttpServletResponse response,int id) {
        Company company = (Company) request.getSession().getAttribute("company");
        ResultData resultData = servicePersonnelratingService.serviceListView(company.getId(),id);
        return JSON.toJSONString(resultData);
    }


}
