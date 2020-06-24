package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.CompanyMangeMapper;
import com.cykj.domestic.service.CompanyManageService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CompanyManageServiceImpl implements CompanyManageService {

    @Autowired
    private CompanyMangeMapper companyMangeMapper;

    @Override
    public ResultData queryCompany(Company company,int page, int limit,String address) {
        List<Company> list=companyMangeMapper.queryCompany(company,(page-1)*limit,limit,address);
        int count=companyMangeMapper.CompanyCount(company,address);
        List<Company> companyList = new ArrayList<>();
        for(Company c : list){
            if(c.getHead()!=null && !c.getHead().isEmpty()) {
                c.setHead(c.getHead().replaceAll("\\\\","/"));
            }
            companyList.add(c);
        }
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(companyList);
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

    @Override
    public ResultData queryCompanyByService(Company company, int page, int limit, String serviceId) {
        List<Company> list=companyMangeMapper.queryCompanyByService(company,(page-1)*limit,limit,serviceId);
        List<Company> companyList = new ArrayList<>();
        for(Company c : list){
            if(c.getHead()!=null && !c.getHead().isEmpty()) {
                c.setHead(c.getHead().replaceAll("\\\\","/"));
            }
            companyList.add(c);
        }

        int count=companyMangeMapper.countCompanyByService(company,serviceId);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(companyList);
        return resultData;
    }

    @Override
    public Company queryCompanyOrderNum(int companyId) {
        Company company = companyMangeMapper.queryCompanyOrderNum(companyId);
        System.out.println("company-------------->>>>:"+company.toString());
        if(company.getHead()!=null && !company.getHead().isEmpty()) {
            company.setHead(company.getHead().replaceAll("\\\\", "/"));
        }
        return company;
    }
}
