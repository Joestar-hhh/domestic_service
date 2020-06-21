package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.UserClock;
import com.cykj.domestic.service.UserClockService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/userClockController")
public class UserClockController {

    @Autowired
    private UserClockService userClockService;

    // 查询用户积分
    @RequestMapping("/queryIntegral")
    public String queryIntegral(UserClock userClock) {
        ResultData resultData = userClockService.queryIntegral(userClock);
        return JSON.toJSONString(resultData);
    }

    // 查询用户连续签到天数
    @RequestMapping("/queryContinuousSign")
    public String queryContinuousSign(UserClock userClock) {
        ResultData resultData = userClockService.queryContinuousSign(userClock);
        return JSON.toJSONString(resultData);
    }

    //新增数据
    @RequestMapping("/insertSign")
    public String insertSign(UserClock userClock) {
        ResultData resultData = userClockService.queryUser(userClock,userClock.getUserId());
        return JSON.toJSONString(resultData);
    }

    // 查询签到日期
    @RequestMapping("/queryDate")
    public String queryDate(int userId) {
        ResultData resultData = userClockService.queryDate(userId);
        return JSON.toJSONString(resultData);
    }
}
