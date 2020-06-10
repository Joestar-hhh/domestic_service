package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Region;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

//用户
@Repository
@Mapper
public interface StaffMapper {

    /*
    员工管理
     */
    //查询列表
    List<Staff> queryStaff(@Param("e") Staff staff, @Param("start") int start, @Param("pageSize") int pageSize, @Param("region") String region);

    //查询总数
    int queryStaffCount(@Param("e") Staff staff, @Param("region") String region);

    //启用状态
    int enableState(int id);

    //禁用状态
    int disableState(int id);

    //查看详情
    List<Staff> checkStaff(int id);

    //区域列表
    List<Region> regionList();

    /*
    用户管理
     */
    //查询用户列表
    List<User> queryUser(@Param("e") User user, @Param("start") int start, @Param("pageSize") int pageSize, @Param("region") String region);

    //查询用户总数
    int queryUserCount(@Param("e") User user, @Param("region") String region);

    //启用状态
    int enableUser(int id);

    //禁用状态
    int disableUser(int id);

    /*
    用户统计
     */
    List<User>userStatistics(@Param("startDate")String startDate,@Param("endDate")String endDate);

}
