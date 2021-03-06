package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.service.TrainPlanService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // 删除培训计划
    @RequestMapping("/deletePlan")
    public String deleteTrainPlan(HttpServletRequest request, HttpServletResponse response) {
        String planid = request.getParameter("id");
        int id = Integer.parseInt(planid);
        ResultData resultData = trainPlanService.deletePlan(id);
        return JSON.toJSONString(resultData);
    }

    // 修改培训计划
    @RequestMapping("/updatePlan")
    public String updateTrainPlan(HttpServletRequest request, HttpServletResponse response, TrainPlan trainPlan) {
        ResultData resultData = trainPlanService.updatePlan(trainPlan);
        return JSON.toJSONString(resultData);
    }

    // 增加培训计划
    @RequestMapping("/insertPlan")
    public String insertPlan(HttpServletRequest request, HttpServletResponse response, TrainPlan trainPlan) {
        ResultData resultData = trainPlanService.insertPlan(trainPlan);
        return JSON.toJSONString(resultData);
    }

    //    培训次数统计
    @RequestMapping("/planStatistics")
    public String planStatistics(HttpServletRequest request, HttpServletResponse response) {
        String startDate= request.getParameter("startDate");
        String endDate= request.getParameter("endDate");
        List<TrainPlan> colList= trainPlanService.planStatistics(startDate,endDate);
        List<TrainPlan> peoList= trainPlanService.peopleStatistics(startDate,endDate);
        Map<String,List<?>> map=new HashMap<>();
        map.put("colList",colList);
        map.put("peoList",peoList);
        return JSON.toJSONString(map);
    }

    //查询所有未参加培训计划的员工
    @RequestMapping("/queryStaffTrain")
    public String queryStaffTrain(HttpServletResponse response,HttpServletRequest request,TrainPlan trainPlan){
        Company company = (Company) request.getSession().getAttribute("company");
        trainPlan.setCompanyId(company.getId());
        ResultData resultData= trainPlanService.queryStaffTrain(trainPlan);
        return JSON.toJSONString(resultData);
    }

    //公司为员工报名培训计划
    @RequestMapping("/insertStaffTrain")
    public String insertStaffTrain(HttpServletRequest request,HttpServletResponse response,TrainPlan trainPlan){
       ResultData resultData= trainPlanService.insertStaffTrain(trainPlan);
        return JSON.toJSONString(resultData);
//
    }
}
