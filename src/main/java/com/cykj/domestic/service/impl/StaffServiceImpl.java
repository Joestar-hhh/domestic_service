package com.cykj.domestic.service.impl;

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
    public ResultData queryStaffList(Staff staff, int page, int limit) {

        List<Staff> list = staffMapper.queryStaff(staff,(page-1)*limit,limit);
        int count = staffMapper.queryStaffCount(staff);

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
}
