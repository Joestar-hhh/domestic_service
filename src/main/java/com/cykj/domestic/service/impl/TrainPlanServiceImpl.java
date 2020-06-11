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

    @Override
    public ResultData deletePlan(int id) {
        int i = trainPlanMapper.deletePlan(id);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }

    @Override
    public ResultData updatePlan(TrainPlan trainPlan) {
        int i = trainPlanMapper.updatePlan(trainPlan);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }

    @Override
    public ResultData insertPlan(TrainPlan trainPlan) {
        int i = trainPlanMapper.insertPlan(trainPlan);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("增加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("增加失败");
        }
        return resultData;
    }
    /*
    培训统计
    */
    @Override
    public List<TrainPlan> planStatistics(String startDate, String endDate) {
        List<TrainPlan>planlist=trainPlanMapper.planStatistics(startDate,endDate);

        return planlist;
    }

    @Override
    public List<TrainPlan> peopleStatistics(String startDate, String endDate) {
        List<TrainPlan>peolist=trainPlanMapper.peopleStatistics(startDate,endDate);
        return peolist;
    }
}
