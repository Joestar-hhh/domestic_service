package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.CompanyAccount;
import com.cykj.domestic.entity.Database;
import com.cykj.domestic.mapper.CompanyAccountMapper;
import com.cykj.domestic.mapper.DataBaseMapper;
import com.cykj.domestic.service.CompanyAccountService;
import com.cykj.domestic.service.DataBaseService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class CompanyAccountImpl implements CompanyAccountService {

    @Autowired
    public CompanyAccountMapper companyAccountMapper;


    //查询公司资料数据
    @Override
    public ResultData selectList(CompanyAccount companyAccount, int page, int pageSize, int userid) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<CompanyAccount> list = companyAccountMapper.selectList(companyAccount, start, pageSize,userid);
        int count = companyAccountMapper.selectListCount(companyAccount,userid);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(companyAccount);
        } else {
            resultData.setCode(1);
            resultData.setMsg("暂无数据");
        }
        return resultData;
    }


    //查询公司资料数据
    @Override
    public ResultData selectbalance(CompanyAccount companyAccount,int userid) {
//        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<CompanyAccount> list = companyAccountMapper.selectbalance(companyAccount,userid);
        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
//            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(companyAccount);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }
}
