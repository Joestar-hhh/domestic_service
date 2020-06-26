package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.entity.StaffEvaluation;
import com.cykj.domestic.service.ServiceEvaluationService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
@RequestMapping("/serviceEvaluationController")
public class ServiceEvaluationController {

    @Autowired
    private ServiceEvaluationService serviceEvaluationService;

    @RequestMapping("/queryServiceEvaluationList")
    public String queryServiceEvaluationList(HttpServletRequest request, HttpServletResponse response,
                                             ServiceEvaluation serviceEvaluation, String page, String limit) {
        Company company = (Company) request.getSession().getAttribute("company");
        ResultData resultData = serviceEvaluationService.queryServiceEvaluationList(serviceEvaluation, Integer.parseInt(page), Integer.parseInt(limit), company.getId());
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/updateContent")
    public String insertContent(HttpServletRequest request, HttpServletResponse response, String content, int id) {
        ResultData resultData = serviceEvaluationService.updateContent(content, new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss").format(new Date()), id);
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/insertEvalution")
    public String insertEvalution(ServiceEvaluation serviceEvaluation, StaffEvaluation staffEvaluation){
           ResultData resultData= serviceEvaluationService.insertEvaluation(serviceEvaluation,staffEvaluation);
           return  JSON.toJSONString(resultData);
    }

    @RequestMapping("/queryCompanyEvaluation")
    public String queryCompanyEvaluation(HttpServletRequest request){
        String companyId=request.getParameter("companyId");
        ResultData resultData=serviceEvaluationService.queryCompanyEvaluation(companyId);
        return JSON.toJSONString(resultData);
    }
}
