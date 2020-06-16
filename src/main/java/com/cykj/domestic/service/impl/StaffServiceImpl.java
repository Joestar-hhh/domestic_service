package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.Region;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.mapper.CompanyMapper;
import com.cykj.domestic.mapper.StaffMapper;
import com.cykj.domestic.service.StaffService;
import com.cykj.domestic.util.AgeUtil;
import com.cykj.domestic.util.CompanyUtil;
import com.cykj.domestic.util.MD5Util;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StaffServiceImpl implements StaffService {

    @Autowired
    private StaffMapper staffMapper;
    @Autowired
    private CompanyMapper companyMapper;


    @Override
    public ResultData queryStaffList(Staff staff, int page, int limit, String region) {

        List<Staff> list = staffMapper.queryStaff(staff, (page - 1) * limit, limit, region);
        int count = staffMapper.queryStaffCount(staff,region);

        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;

    }

    @Override
    public int enableState(int id) {
        int res = staffMapper.enableState(id);
        return res;
    }

    @Override
    public int disableState(int id) {
        int res = staffMapper.disableState(id);
        return res;
    }

    @Override
    public List<Staff> checkStaff(int id) {
        List<Staff> list = staffMapper.checkStaff(id);
        return list;
    }

    @Override
    public ResultData regionList() {
        List<Region> list = staffMapper.regionList();
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
//用户管理查询
    @Override
    public ResultData queryUser(User user, int page, int limit, String region) {
        List<User> list = staffMapper.queryUser(user, (page - 1) * limit, limit, region);
        int count = staffMapper.queryUserCount(user,region);

        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData enableUser(int id) {
        int res = staffMapper.enableUser(id);
        ResultData resultData=new ResultData();
        if (res==1){
            resultData.setCode(0);
            resultData.setMsg("启用成功！");
        }else {
            resultData.setCode(1);
            resultData.setMsg("启用失败！");
        }
        return resultData;
    }

    @Override
    public ResultData disableUser(int id) {
        int res = staffMapper.disableUser(id);
        ResultData resultData=new ResultData();
        if (res==1){
            resultData.setCode(0);
            resultData.setMsg("禁用成功！");
        }else {
            resultData.setCode(1);
            resultData.setMsg("禁用失败！");
        }
        return resultData;
    }
    /*
    * 用户统计
    * */
    @Override
    public List<User> userStatistics(String startDate, String endDate) {

        List<User>userList=staffMapper.userStatistics(startDate,endDate);

        return userList;
    }

    @Override
    public ResultData queryCompanyStaff(String userName, int companyId, int page, int limit) {
        List<Staff> list = staffMapper.queryCompanyStaff(userName, companyId, (page - 1) * limit, limit);
        int count = staffMapper.queryCompanyStaffConut(userName, companyId);

        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData insertCompanyStaff(Staff staff, String CityLevel, String CountyLevel, Company company) {
        String regionName = CityLevel+CountyLevel;
        System.out.println("地区："+regionName);
        staff.setAddress(regionName+staff.getAddress());
        int age = AgeUtil.getAgeFromBirthTime(staff.getBirthDate());//计算年龄
        System.out.println("年龄："+age);
        staff.setAge(age);
        staff.setPwd(MD5Util.MakeMd5("123456"));
        staff.setCompanyId(String.valueOf(company.getId()));
        String maxAcc = staffMapper.queryStaffMaxAccount();

        staff.setAccount(CompanyUtil.getAccount(maxAcc,company.getAccount()));
        int res = staffMapper.insertCompanyStaff(staff);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("注册成功,请牢记账号和密码!" +
                    "\n\t员工账号："+staff.getAccount()+"\n\t初始密码："+123456);
        }else {
            resultData.setCode(1);
            resultData.setMsg("注册失败");
        }
        return resultData;
    }

    @Override
    public ResultData queryStaffPhone(String phone) {
        Staff staff = staffMapper.queryStaffPhone(phone);
        ResultData resultData = new ResultData();
        if(staff!=null){
            resultData.setCode(0);
            resultData.setMsg("该手机号已存在");
        }else{
            resultData.setCode(1);
        }
        return resultData;
    }

    @Override
    public ResultData queryStaffIdcard(String idcard) {
        Staff staff = staffMapper.queryStaffIdcard(idcard);
        ResultData resultData = new ResultData();
        if(staff!=null){
            resultData.setCode(0);
            resultData.setMsg("该身份证号已存在");
        }else{
            resultData.setCode(1);
        }
        return resultData;
    }

    @Override
    public String queryStaffMaxAccount() {
        return staffMapper.queryStaffMaxAccount();
    }

    @Override
    public ResultData updateCompanyStaff(Staff staff, String CityLevel,String CountyLevel) {
        String regionName = CityLevel+CountyLevel;
        System.out.println("地区："+regionName);
        staff.setAddress(regionName+staff.getAddress());
        int age = AgeUtil.getAgeFromBirthTime(staff.getBirthDate());//计算年龄
        System.out.println("年龄："+age);
        staff.setAge(age);
        int res = staffMapper.updateCompanyStaff(staff);
        ResultData resultData = new ResultData();
        if(res>=1){
            resultData.setCode(0);
            resultData.setMsg("员工信息修改成功");
        }else{
            resultData.setCode(1);
            resultData.setMsg("员工信息修改成功");
        }
        return resultData;
    }

    @Override
    public ResultData updateStaffJobState(String jobState, int staffId) {
        int res = staffMapper.updateStaffJobState(jobState,staffId);
        ResultData resultData = new ResultData();
        if(res>=1){
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        }else{
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }

    @Override
    public ResultData deleteStaff(int staffId) {
        int res = staffMapper.deleteStaff(staffId);
        ResultData resultData = new ResultData();
        if(res>=1){
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        }else{
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }


}
