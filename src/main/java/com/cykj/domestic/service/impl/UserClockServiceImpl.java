package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.UserClock;
import com.cykj.domestic.mapper.UserClockMapper;
import com.cykj.domestic.service.UserClockService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserClockServiceImpl implements UserClockService {

    @Autowired
    private UserClockMapper userClockMapper;

    @Override
    public ResultData queryIntegral(UserClock userClock) {
        int integral = userClockMapper.queryIntegral(userClock);
        ResultData resultData = new ResultData();
        resultData.setCount(integral);
        return resultData;
    }

    @Override
    public ResultData queryContinuousSign(UserClock userClock) {
        int continuousSign = userClockMapper.queryContinuousSign(userClock);
        ResultData resultData = new ResultData();
        resultData.setCount(continuousSign);
        return resultData;
    }

    @Override
    public ResultData queryUser(UserClock userClock, int id) {
        UserClock user = userClockMapper.queryUser(id);
        ResultData resultData = new ResultData();
        int res = 0;
        if (user != null) {
            res = userClockMapper.updateSign(userClock);
            resultData.setCount(res);
            System.out.println("修改结果为:" + res);
        } else {
            res = userClockMapper.insertSign(userClock);
            resultData.setCount(res);
            System.out.println("增加结果为：" + res);
        }
        return resultData;
    }

    @Override
    public ResultData queryDate(int userId) {
        UserClock userClock = userClockMapper.queryDate(userId);
        ResultData resultData = new ResultData();
        resultData.setMsg(userClock.getClockTime());
        return resultData;
    }
}
