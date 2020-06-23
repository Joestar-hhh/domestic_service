package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.AfterSalesApplication;
import com.cykj.domestic.entity.Annoucement;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.mapper.AfterSalesApplicationMapper;
import com.cykj.domestic.service.AfterSalesApplicationService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.naming.ldap.Rdn;
import java.util.List;

@Service
public class AfterSalesApplicationServiceImpl implements AfterSalesApplicationService {

    @Autowired
    private AfterSalesApplicationMapper afterSalesApplicationMapper;


    @Override
    public ResultData queryAfterSalesApplication(AfterSalesApplication afterSalesApplication, int page, int limit, int id ,String orderNumber) {
        List<AfterSalesApplication> list = afterSalesApplicationMapper.queryAfterSalesApplication(afterSalesApplication, (page - 1) * limit, limit, id ,orderNumber);
        int count = afterSalesApplicationMapper.queryAfterSalesApplicationCount(afterSalesApplication, id ,orderNumber);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData passCheck(int id) {
        int res = afterSalesApplicationMapper.passCheck(id);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("审核通过");
        } else {
            resultData.setCode(1);
            resultData.setMsg("操作失败");
        }
        return resultData;
    }

    @Override
    public ResultData nopassCheck(int id) {
        int res = afterSalesApplicationMapper.nopassCheck(id);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("审核不通过");
        } else {
            resultData.setCode(1);
            resultData.setMsg("操作失败");
        }
        return resultData;
    }

    @Override
    public ResultData queryArrangeAfterSales(AfterSalesApplication afterSalesApplication, int page, int limit, int id,String orderNumber) {
        List<AfterSalesApplication> list = afterSalesApplicationMapper.queryArrangeAfterSales(afterSalesApplication, (page - 1) * limit, limit, id ,orderNumber);
        int count = afterSalesApplicationMapper.queryArrangeAfterSalesCount(afterSalesApplication, id ,orderNumber);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData queryStaffName(int id) {
        List<Staff> list = afterSalesApplicationMapper.queryStaffName(id);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData arrangeStaff(String staffId,int id) {
        int res = afterSalesApplicationMapper.arrangeStaff(staffId,id);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("已安排售后");
        } else {
            resultData.setCode(1);
            resultData.setMsg("操作失败,请重试");
        }
        return resultData;
    }

    @Override
    public ResultData insertSaleApply(AfterSalesApplication afterSalesApplication) {
       int res= afterSalesApplicationMapper.insertSaleApply(afterSalesApplication);
        ResultData resultData=new ResultData();
        if(res==1){
            System.out.println("申请成功");
            resultData.setCode(0);
            resultData.setMsg("申请成功");
        } else {
            System.out.println("申请成功");
            resultData.setCode(1);
            resultData.setMsg("申请失败");
        }
        return resultData;
    }
}
