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
}
