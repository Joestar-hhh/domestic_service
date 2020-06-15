package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Qualification;
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
    private SkillTrainMapper skillTrainMapper;


    //技能培训分页
    @Override
    public ResultData querySkillTrain(int page, int limit) {
        List<SkillTrain> list = skillTrainMapper.querySkillTrain((page - 1) * limit, limit);
        int count = skillTrainMapper.querySkillTraincount();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    //删除技能培训
    @Override
    public ResultData deleteSkillTrain(String id) {
        int i = skillTrainMapper.deleteSkillTrain(id);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
            resultData.setCount(i);
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
            resultData.setCount(i);
        }
        return resultData;
    }


    //查找所有技能证书
    @Override
    public ResultData queryqualification() {
        List<Qualification> list = skillTrainMapper.queryqualification();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("删除成功");
        resultData.setData(list);
        return resultData;
    }

    //修改技能培训项目
    @Override
    public ResultData updateSkillTrain(SkillTrain skillTrain) {
        int i = skillTrainMapper.updateSkillTrain(skillTrain);
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

    //添加技能培训
    @Override
    public ResultData insertSkillTrain(SkillTrain skillTrain) {
        int i = skillTrainMapper.insertSkillTrain(skillTrain);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;
    }

    //添加技能证书
    @Override
    public ResultData insertqualification(Qualification qualification) {
        int res = skillTrainMapper.insertqualification(qualification);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;
    }

    /*获取培训风采图片路径*/
    @Override
    public ResultData querySkillStyle(SkillTrain skillTrain) {
        List<SkillTrain> list = skillTrainMapper.querySkillStyle(skillTrain);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

    /*添加上传的培训风采图片*/
    @Override
    public ResultData insertSkillStyle(SkillTrain skillTrain) {
        int res = skillTrainMapper.insertSkillStyle(skillTrain);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("上传成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("上传失败");
        }
        return resultData;
    }


}
