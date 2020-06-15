package com.cykj.domestic.service;

import com.cykj.domestic.entity.Region;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.util.ResultData;

import java.util.List;

public interface StaffService {

    ResultData queryStaffList(Staff staff, int page, int limit ,String region);

    int enableState(int id);

    int disableState(int id);

    List<Staff> checkStaff(int id);

    ResultData regionList();

    //用户管理
    ResultData queryUser(User user, int page, int limit, String region);

    ResultData enableUser(int id);

    ResultData disableUser(int id);

//    用户统计
    List<User>userStatistics(String startDate,String endDate);


    ResultData queryCompanyStaff(int companyId, int page, int limit);

    ResultData insertCompanyStaff(Staff staff, String CityLevel,String CountyLevel);

    //查询手机号是否存在
    ResultData queryStaffPhone(String phone);
    //查询身份证是否存在
    ResultData queryStaffIdcard(String idcard);
}
