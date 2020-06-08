package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.service.TrainPlanService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/trainPlanController")
public class TrainPlanController {

    @Autowired
    private TrainPlanService trainPlanService;

    //查询顾问管理信息--
    @RequestMapping("/queryTrainPlanList")
    public String queryTrainPlan(HttpServletRequest request, HttpServletResponse response,
                                 TrainPlan trainPlan, String page, String limit) {
        ResultData resultData = trainPlanService.queryTrainPlanList(trainPlan, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }
}
