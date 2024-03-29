package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.UserClock;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface UserClockMapper {

    // 查询用户积分总数
    int queryIntegral(int userId);

    // 查询连续签到天数
    int queryContinuousSign(int userId);

    // 新增签到数据
    int insertSign(@Param("e") UserClock userClock, @Param("userId") int userId);

    // 修改签到数据
    int updateSign(UserClock userClock);

    // 查询用户
    UserClock queryUser(int id);

    // 查询签到日期
    UserClock queryDate(int userId);
}
