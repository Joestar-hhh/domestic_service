package com.cykj.domestic.service;

import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.util.ResultData;


public interface TrainPlanService {

    ResultData queryTrainPlanList(TrainPlan trainPlan, int page, int limit);

    //删除计划
    ResultData deletePlan(int id);

    //修改计划
    ResultData updatePlan(TrainPlan trainPlan);

    //增加计划
    ResultData insertPlan(TrainPlan trainPlan);
}
