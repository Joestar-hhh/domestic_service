package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Region;
import com.cykj.domestic.entity.Staff;
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

//    @Override
//    public ResultData queryRegion(Staff staff, int page, int limit, String region) {
//        List<Staff> list = staffMapper.queryRegion(staff, (page - 1) * limit, limit, region);
//        int count = staffMapper.queryStaffCount(staff);
//
//        ResultData resultData = new ResultData();
//        resultData.setCode(0);
//        resultData.setMsg("");
//        resultData.setCount(count);
//        resultData.setData(list);
//        return resultData;
//    }
}
