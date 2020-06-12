package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.mapper.ServiceEvaluationMapper;
import com.cykj.domestic.service.ServiceEvaluationService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServiceEvaluationImpl implements ServiceEvaluationService {

    @Autowired
    private ServiceEvaluationMapper serviceEvaluationMapper;

    @Override
    public ResultData queryServiceEvaluationList(ServiceEvaluation serviceEvaluation, int page, int limit) {
        List<ServiceEvaluation> list = serviceEvaluationMapper.queryServiceEvaluationList(serviceEvaluation, (page - 1) * limit, limit);
        int count = serviceEvaluationMapper.queryServiceEvaluationCount(serviceEvaluation);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;

    }
}
