package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.UserClock;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface UserClockMapper {

    // 查询用户积分总数
    int queryIntegral(UserClock userClock);

    //查询连续签到天数
    int queryContinuousSign(UserClock userClock);
}
