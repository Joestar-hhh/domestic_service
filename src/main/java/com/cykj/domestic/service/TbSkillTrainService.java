package com.cykj.domestic.service;

import com.cykj.domestic.entity.TbSkillTrain;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TbSkillTrainService {

    ResultData querySkillTrain(int page, int limit);

    //删除
    ResultData deleteSkillTrain(String id);


}
