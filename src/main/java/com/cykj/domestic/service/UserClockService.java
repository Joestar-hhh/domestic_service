package com.cykj.domestic.service;

import com.cykj.domestic.entity.UserClock;
import com.cykj.domestic.util.ResultData;

public interface UserClockService {

    // 查询用户积分总数
    ResultData queryIntegral(int userId);

    //查询连续签到天数
    ResultData queryContinuousSign(int userId);

    // 根据用户id查询签到数据
    ResultData queryUser(UserClock userClock,int userId);

    // 查询用户签到日期
    ResultData queryDate(int userId);

    // 点击签到
    ResultData updateSign(UserClock userClock);
}
