package com.cykj.domestic.service;

import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.util.ResultData;


public interface TrainPlanService {

    ResultData queryTrainPlanList(TrainPlan trainPlan, int page, int limit);
}
