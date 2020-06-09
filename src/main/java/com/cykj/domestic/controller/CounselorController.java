package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Counselor;
import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.service.CounselorService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/counselorController")
public class CounselorController {

    @Autowired
    private CounselorService counselorService;

    //查询顾问管理信息
    @RequestMapping("/queryCounselor")
    public String queryCounselor(HttpServletRequest request, HttpServletResponse response,
                                 Counselor counselor, String page, String limit) {
        ResultData resultData = counselorService.queryCounselorList(counselor, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    // 删除培训计划
    @RequestMapping("/deleteCounselor")
    public String deleteCounselor(HttpServletRequest request, HttpServletResponse response) {
        String planid = request.getParameter("id");
        int id = Integer.parseInt(planid);
        ResultData resultData = counselorService.deleteCounselor(id);
        return JSON.toJSONString(resultData);
    }

    // 修改培训计划
    @RequestMapping("/updateCounselor")
    public String updateCounselor(HttpServletRequest request, HttpServletResponse response, Counselor counselor) {
        ResultData resultData = counselorService.updateCounselor(counselor);
        return JSON.toJSONString(resultData);
    }

    // 增加培训计划
    @RequestMapping("/insertCounselor")
    public String insertCounselor(HttpServletRequest request, HttpServletResponse response, Counselor counselor) {
        ResultData resultData = counselorService.insertCounselor(counselor);
        return JSON.toJSONString(resultData);
    }
}
