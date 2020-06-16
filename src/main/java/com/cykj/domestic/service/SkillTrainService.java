package com.cykj.domestic.service;

import com.cykj.domestic.entity.Qualification;
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

    ResultData insertSkillTrain(SkillTrain skillTrain);

    //添加技能证书
    ResultData insertqualification(Qualification qualification);

    /*获取培训风采图片路径*/
    ResultData querySkillStyle(SkillTrain skillTrain);

    /*添加上传的培训风采图片*/
    ResultData insertSkillStyle(SkillTrain skillTrain);


}
