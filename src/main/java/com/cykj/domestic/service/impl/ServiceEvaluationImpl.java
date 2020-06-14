package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.mapper.ServiceEvaluationMapper;
import com.cykj.domestic.service.ServiceEvaluationService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.naming.ldap.Rdn;
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

    @Override
    public ResultData updateContent(String content, String contentTime,int id) {
        int res = serviceEvaluationMapper.updateContent(content,contentTime,id);
        ResultData resultData  = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("回复成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("回复失败");
        }
        return resultData;
    }
}
