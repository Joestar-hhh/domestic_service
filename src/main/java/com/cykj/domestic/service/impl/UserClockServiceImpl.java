package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.UserClock;
import com.cykj.domestic.mapper.UserClockMapper;
import com.cykj.domestic.service.UserClockService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserClockServiceImpl implements UserClockService {

    @Autowired
    private UserClockMapper userClockMapper;

    // 查询积分
    @Override
    public ResultData queryIntegral(int userId) {
        int integral = userClockMapper.queryIntegral(userId);
        ResultData resultData = new ResultData();
        resultData.setCount(integral);
        return resultData;
    }

    // 查询连续签到日期
    @Override
    public ResultData queryContinuousSign(int userId) {
        int continuousSign = userClockMapper.queryContinuousSign(userId);
        ResultData resultData = new ResultData();
        resultData.setCount(continuousSign);
        return resultData;
    }

    // 查询是否有该用户，如果没有就执行插入一条新数据。
    @Override
    public ResultData queryUser(UserClock userClock, int userId) {
        UserClock user = userClockMapper.queryUser(userId);
        ResultData resultData = new ResultData();
        int res = 0;
        if (user != null) {
            UserClock userClock1 = userClockMapper.queryDate(userId);
            int continuousSign = userClockMapper.queryContinuousSign(userId);
            int integral = userClockMapper.queryIntegral(userId);
            userClock1.setIntegral(integral);
            userClock1.setContinuousSign(continuousSign);
            List<UserClock> list = new ArrayList<>();
            list.add(userClock1);
            resultData.setData(list);
        } else {
            res = userClockMapper.insertSign(userClock,userId);
            resultData.setCount(res);
        }
        return resultData;
    }

    // 查询签到日期
    @Override
    public ResultData queryDate(int userId) {
        UserClock userClock = userClockMapper.queryDate(userId);
        ResultData resultData = new ResultData();
        resultData.setMsg(userClock.getClockTime());
        return resultData;
    }

    // 点击签到按钮执行修改数据库的操作
    @Override
    public ResultData updateSign(UserClock userClock) {
        int res = userClockMapper.updateSign(userClock);
        ResultData resultData = new ResultData();
        resultData.setCount(res);
        return resultData;
    }
}
