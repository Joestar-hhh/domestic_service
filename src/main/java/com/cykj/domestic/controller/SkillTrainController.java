package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.cykj.domestic.entity.SkillTrain;
import com.cykj.domestic.service.SkillTrainService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/skillTrainController")
public class SkillTrainController {

    @Autowired
    private SkillTrainService skillTrainService;

    //技能培训列表
    @ResponseBody
    @RequestMapping(value = "/querySkillTrain")
    public String querySkillTrain(HttpServletRequest request, HttpServletResponse response, String page, String limit) {
        System.out.println("querySkillTrain--------------limit:" + limit + "--------page:" + page);
        ResultData resultData = skillTrainService.querySkillTrain(Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData, SerializerFeature.DisableCircularReferenceDetect);
    }

    @ResponseBody
    @RequestMapping(value = "/deleteSkillTrain")
    public String deleteSkillTrain(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        System.out.println("技能培训=" + id);
        ResultData resultData = skillTrainService.deleteSkillTrain(id);
        return JSON.toJSONString(resultData);
    }

    //    查找所有技能证书
    @ResponseBody
    @RequestMapping(value = "/queryqualification")
    public String queryqualification(HttpServletRequest request, HttpServletResponse response) {
        ResultData resultData = skillTrainService.queryqualification();
        return JSON.toJSONString(resultData);
    }

    //    修改技能培训
    @ResponseBody
    @RequestMapping(value = "/updateSkillTrain")
    public String updateSkillTrain(HttpServletRequest request, HttpServletResponse response, SkillTrain skillTrain) {
        System.out.println("updateSkillTrain="+JSON.toJSONString(skillTrain));
        ResultData resultData = skillTrainService.updateSkillTrain(skillTrain);
        return JSON.toJSONString(resultData);
    }

    //添加技能培训项目
    @ResponseBody
    @RequestMapping(value = "/insertSkillTrain")
    public String insertSkillTrain(HttpServletRequest request, HttpServletResponse response, SkillTrain skillTrain) {
        System.out.println("insertSkillTrain="+JSON.toJSONString(skillTrain));
        ResultData resultData = skillTrainService.insertSkillTrain(skillTrain);
        System.out.println(JSON.toJSONString(resultData));
        return JSON.toJSONString(resultData);
    }
}
