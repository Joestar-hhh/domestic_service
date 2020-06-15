package com.cykj.domestic.service;

import com.cykj.domestic.entity.Company;
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

    ResultData insertCompanyStaff(Staff staff, String CityLevel, String CountyLevel, Company company);

    //查询手机号是否存在
    ResultData queryStaffPhone(String phone);
    //查询身份证是否存在
    ResultData queryStaffIdcard(String idcard);
    //查询最大员工账号
    String queryStaffMaxAccount();

    //修改员工信息
    ResultData updateCompanyStaff(Staff staff, String CityLevel,String CountyLevel);

    //修改员工工作状态
    ResultData updateStaffJobState(String jobState,int staffId);
    //删除员工
    ResultData deleteStaff(int staffId);
}
