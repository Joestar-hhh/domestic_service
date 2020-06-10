package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Counselor;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.mapper.OfficeMapper;
import com.cykj.domestic.service.OfficeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OfficeServiceImpl implements OfficeService {

    @Autowired
    private OfficeMapper officeMapper;

    @Override
    public ResultData queryOfficeList(Staff staff, int page, int limit) {
        List<Staff> list = officeMapper.queryOfficeList(staff, (page - 1) * limit, limit);
        int count = officeMapper.queryOfficeCount(staff);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData deleteOffice(int id) {
        int i = officeMapper.deleteOffice(id);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }

    @Override
    public ResultData updateOffice(Staff staff) {
        int i = officeMapper.updateOffice(staff);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }

    @Override
    public ResultData insertOffice(Staff staff) {
        int i = officeMapper.insertOffice(staff);
        ResultData resultData = new ResultData();
        if (i > 0) {
            resultData.setCode(0);
            resultData.setMsg("增加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("增加失败");
        }
        return resultData;
    }

    @Override
    public ResultData counselorList() {
        List<Counselor> list = officeMapper.counselorList();
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
}
