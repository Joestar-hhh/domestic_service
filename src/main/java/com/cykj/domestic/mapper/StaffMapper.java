package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Staff;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

//用户
@Mapper
public interface StaffMapper {

    //查询列表
    List<Staff> queryStaff(@Param("e") Staff staff, @Param("start") int start, @Param("pageSize") int pageSize);

    //查询总数
    int queryStaffCount(@Param("e") Staff staff);
}
