package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.Region;
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


    //    平台端登入
    @Override
    public ResultData companyLogin(Company company) {
        ResultData resultData = new ResultData();
        Company company1 = companyMapper.companyLogin(company);
        if (company1 != null) {
            if (company.getPwd().equals(company1.getPwd())) {
                resultData.setCode(0);
                resultData.setMsg("登入成功");
            } else {
                resultData.setCode(1);
                resultData.setMsg("密码错误");
            }
        } else {
            resultData.setCode(2);
            resultData.setMsg("账号不存在");
        }
        return resultData;
    }

    //区域列表
    @Override
    public ResultData queryRegion(int page, int limit) {
        List<Company> list = companyMapper.queryRegion((page - 1) * limit, limit);
        int count = companyMapper.RegionCount();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    //删除区域
    @Override
    public ResultData deleteRegion(String region) {
        int i = companyMapper.deleteRegion(region);
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

    //查询区域是存在并添加
    @Override
    public ResultData selectRegionPresence(String region) {
        Region region1 = companyMapper.selectRegionPresence(region);
        ResultData resultData = new ResultData();
        if (region1 == null) {
            int i = companyMapper.insertRegion(region);
            if (i > 0) {
                resultData.setCode(0);
                resultData.setMsg("添加成功");
            } else {
                resultData.setCode(1);
                resultData.setMsg("添加失败");
            }
        } else {
            resultData.setCode(2);
            resultData.setMsg("区域已存在");
        }
        return resultData;
    }

    //    根据地区查看平台详情
    @Override
    public ResultData queryRegionCompany(String regionId) {
        List<Company> list = companyMapper.queryRegionCompany(regionId);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

    @Override
    public List<Company> serviceTypeStatistics(String statisticsType, String startDate, String endDate) {
        List<Company> companyList = null;
        if(statisticsType.equals("1")){
            companyList = companyMapper.serviceTypeStatistics();
        }else if (statisticsType.equals("2")){
            companyList = companyMapper.regionStatistics();
        }else {
            companyList = companyMapper.dateStatistics(startDate, endDate);
        }
        return companyList;
    }
}
