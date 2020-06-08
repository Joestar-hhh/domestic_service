package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.mapper.CompanyMapper;
import com.cykj.domestic.service.CompanySrevice;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyImpl implements CompanySrevice {
    @Autowired
    public CompanyMapper companyMapper;

    //区域列表
    @Override
    public ResultData queryRegion(int page, int limit) {
        List<Company> list = companyMapper.queryRegion((page-1)*limit,limit);
        int count = companyMapper.RegionCount();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }
}
