package com.cykj.domestic.service;

import com.cykj.domestic.entity.SkillTrain;
import com.cykj.domestic.util.ResultData;

public interface SkillTrainService {

    ResultData querySkillTrain(int page, int limit);

    //删除---
    ResultData deleteSkillTrain(String id);

    //查找所有技能证书
    ResultData queryqualification();

    //修改技能培训
    ResultData updateSkillTrain(SkillTrain skillTrain);

    //添加技能培训
    ResultData insertSkillTrain(SkillTrain skillTrain);


}
