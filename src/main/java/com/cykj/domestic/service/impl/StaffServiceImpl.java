package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Region;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.mapper.StaffMapper;
import com.cykj.domestic.service.StaffService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StaffServiceImpl implements StaffService {

    @Autowired
    private StaffMapper staffMapper;


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


}
