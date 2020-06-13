package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.Region;
import com.cykj.domestic.mapper.CompanyMapper;
import com.cykj.domestic.service.CompanySrevice;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class CompanyImpl implements CompanySrevice {
    @Autowired
    public CompanyMapper companyMapper;


    //    家政公司端登入
    @Override
    public ResultData companyLogin(Company company, HttpServletRequest request) {
        ResultData resultData = new ResultData();
        HttpSession session = request.getSession();
        Company company1 = companyMapper.companyLogin(company);
        if (company1 != null) {
            if (!company.getPwd().equals(company1.getPwd())) {
                resultData.setCode(1);
                resultData.setMsg("密码错误");
            } else { // if (company1.getRoleId() == 3)
                session.setAttribute("company", company1);
                resultData.setCode(0);
                resultData.setMsg("管理员登入成功");
            }
//            else if(company1.getState().equals("审核通过")){
//                session.setAttribute("company",company1);
//                if (company1.getState().equals("审核通过")) {
//                    resultData.setCode(3);
//                    resultData.setMsg("登入成功");
//                } else {
//                    resultData.setCode(0);
//                    resultData.setMsg("登入成功");
//                }
//            }
        } else {
            resultData.setCode(2);
            resultData.setMsg("账号不存在");
        }
        return resultData;
    }


    //家政公司端修改密码
    @Override
    public ResultData phone_update_pwd(Company company) {
        ResultData resultData = new ResultData();
        Company company1 = companyMapper.querycompanyphone(company);
        if (company1 == null) {
            resultData.setCode(3);
            resultData.setMsg("手机号码不存在，请重新输入");
        } else {
            int res = companyMapper.phone_update_pwd(company);
            if (res == 1) {
                resultData.setCode(0);
                resultData.setMsg("修改成功");
            } else {
                resultData.setCode(1);
                resultData.setMsg("修改失败");
            }
        }
        return resultData;
    }

    /*
        家政公司注册
    */
    @Override
    public ResultData insertCompany(Company company) {
        ResultData resultData = new ResultData();
//        判断账号和手机号是否纯在
        Company companyphone=companyMapper.querycompanyphone(company);
        if(companyphone==null){
           Company companyLogin =companyMapper.companyLogin(company);
           if(companyLogin==null){
               int res= companyMapper.insertCompany(company);
               if (res == 1) {
                   resultData.setCode(0);
                   resultData.setMsg("注册成功");
               } else {
                   resultData.setCode(1);
                   resultData.setMsg("注册失败");
               }
           }else{
                resultData.setCode(2);
                resultData.setMsg("公司账号已存在");
            }
        }else{
            resultData.setCode(3);
            resultData.setMsg("手机号已被注册");
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
        if (statisticsType.equals("1")) {
            companyList = companyMapper.serviceTypeStatistics();
        } else if (statisticsType.equals("2")) {
            companyList = companyMapper.regionStatistics();
        } else {
            companyList = companyMapper.dateStatistics(startDate, endDate);
        }
        return companyList;
    }
}
