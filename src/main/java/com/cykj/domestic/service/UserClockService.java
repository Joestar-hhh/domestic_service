package com.cykj.domestic.service;

import com.cykj.domestic.entity.UserClock;
import com.cykj.domestic.util.ResultData;

public interface UserClockService {

    // 查询用户积分总数
    ResultData queryIntegral(UserClock userClock);

    //查询连续签到天数
    ResultData queryContinuousSign(UserClock userClock);
}
