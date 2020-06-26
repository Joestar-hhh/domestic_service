package com.cykj.domestic.service;

import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.util.ResultData;

import java.util.List;


public interface TrainPlanService {

    ResultData queryTrainPlanList(TrainPlan trainPlan, int page, int limit);

    //删除计划
    ResultData deletePlan(int id);

    //修改计划
    ResultData updatePlan(TrainPlan trainPlan);

    //增加计划
    ResultData insertPlan(TrainPlan trainPlan);

    //培训统计
    List<TrainPlan> planStatistics(String startDate, String endDate);

    List<TrainPlan> peopleStatistics(String startDate, String endDate);

    //查询所有未参加培训计划的员工
    ResultData queryStaffTrain(TrainPlan trainPlan);

    //公司为员工报名培训计划
    ResultData insertStaffTrain(TrainPlan trainPlan);



}

