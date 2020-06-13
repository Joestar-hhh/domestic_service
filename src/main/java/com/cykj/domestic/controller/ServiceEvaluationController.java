package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.service.ServiceEvaluationService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/serviceEvaluationController")
public class ServiceEvaluationController {

    @Autowired
    private ServiceEvaluationService serviceEvaluationService;

    @RequestMapping("/queryServiceEvaluationList")
    public String queryServiceEvaluationList(HttpServletRequest request, HttpServletResponse response,
                                             ServiceEvaluation serviceEvaluation, String page, String limit) {
        ResultData resultData = serviceEvaluationService.queryServiceEvaluationList(serviceEvaluation, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);

    }
}
