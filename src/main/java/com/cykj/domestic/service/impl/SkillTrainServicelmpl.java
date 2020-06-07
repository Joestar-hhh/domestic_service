package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.SkillTrain;
import com.cykj.domestic.mapper.SkillTrainMapper;
import com.cykj.domestic.service.SkillTrainService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SkillTrainServicelmpl implements SkillTrainService {


    @Autowired
    private SkillTrainMapper tbSkillTrainMapper;


    @Override
    public ResultData querySkillTrain(int page, int limit) {
        List<SkillTrain>list = tbSkillTrainMapper.querySkillTrain((page - 1) * limit, limit);
        int count = tbSkillTrainMapper.querySkillTraincount();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

}
