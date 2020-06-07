package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
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
    @RequestMapping(value = "")
    public String deleteSkillTrain() {

        return null;
    }


}
