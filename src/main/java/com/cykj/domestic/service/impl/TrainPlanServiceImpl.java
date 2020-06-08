package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.mapper.TrainPlanMapper;
import com.cykj.domestic.service.TrainPlanService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainPlanServiceImpl implements TrainPlanService {

    @Autowired
    private TrainPlanMapper trainPlanMapper;

    @Override
    public ResultData queryTrainPlanList(TrainPlan trainPlan, int page, int limit) {
        List<TrainPlan> list = trainPlanMapper.queryTrainPlanList(trainPlan, (page - 1) * limit, limit);
        int count = trainPlanMapper.queryTrainPlanCount(trainPlan);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }
}
