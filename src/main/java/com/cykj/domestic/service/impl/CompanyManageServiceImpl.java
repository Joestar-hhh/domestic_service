package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.mapper.CompanyMangeMapper;
import com.cykj.domestic.service.CompanyManageService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyManageServiceImpl implements CompanyManageService {

    @Autowired
    private CompanyMangeMapper companyMangeMapper;

    @Override
    public ResultData queryCompany(Company company,int page, int limit) {
        List<Company> list=companyMangeMapper.queryCompany(company,(page-1)*limit,limit);
        int count=companyMangeMapper.CompanyCount(company);

        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData checkJoin(Company company) {
        int res=companyMangeMapper.checkJoin(company);
        ResultData resultData=new ResultData();
        if (res==1){
            resultData.setCode(0);
            resultData.setMsg("审核成功！");
        }else {
            resultData.setCode(1);
            resultData.setMsg("审核失败！");
        }
        return resultData;
    }
}
