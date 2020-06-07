package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.TbSkillTrain;
import com.cykj.domestic.mapper.TbSkillTrainMapper;
import com.cykj.domestic.service.TbSkillTrainService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TbSkillTrainServicelmpl implements TbSkillTrainService {


    @Autowired
    private TbSkillTrainMapper tbSkillTrainMapper;


    @Override
    public ResultData querySkillTrain(int page, int limit) {
        List<TbSkillTrain>list = tbSkillTrainMapper.querySkillTrain((page - 1) * limit, limit);
        int count = tbSkillTrainMapper.querySkillTraincount();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

}
