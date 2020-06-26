package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.DistributeLeaflets;
import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.entity.PriceRelation;
import com.cykj.domestic.service.DistributeLeafletsService;
import com.cykj.domestic.service.ServicePersonnelratingService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/distributeLeafletsController")
public class DistributeLeafletsController {

    @Autowired
    private DistributeLeafletsService distributeLeafletsService;

    @RequestMapping("/queryServiceEvaluationList")
    public String queryServiceEvaluationList(HttpServletRequest request, HttpServletResponse response,
                                             DistributeLeaflets distributeLeaflets, String page, String limit) {
        Company company = (Company) request.getSession().getAttribute("company");
        ResultData resultData = distributeLeafletsService.queryServiceEvaluationList(distributeLeaflets, Integer.parseInt(page), Integer.parseInt(limit), company.getId());
        return JSON.toJSONString(resultData);
    }


    @RequestMapping("/selectStaff")
    public String selectStaff(HttpServletRequest request, HttpServletResponse response,
                                             DistributeLeaflets distributeLeaflets) {
        Company company = (Company) request.getSession().getAttribute("company");
        ResultData resultData = distributeLeafletsService.selectStaff(distributeLeaflets, company.getId());
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/updatePaiDan")
    public String updateServicePrice(HttpServletRequest request, PriceRelation priceRelation,int userId,int id) {
        ResultData resultData = distributeLeafletsService.updatePaiDan(userId,id);
        return JSON.toJSONString(resultData);
    }


}
