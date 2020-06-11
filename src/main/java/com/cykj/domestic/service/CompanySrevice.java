package com.cykj.domestic.service;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.mapper.CompanyMapper;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.util.List;

public interface CompanySrevice {

    //   家政公司端登入
    ResultData companyLogin(Company company, HttpServletRequest request);

    //家政公司端修改密码
    ResultData phone_update_pwd(Company company);

    //平台端区域列表
    ResultData queryRegion(int page, int limit);

    //删除区域
    ResultData deleteRegion(String region);

    //查询区域是存在并添加
    ResultData selectRegionPresence(String region);

    //    根据地区查看平台详情
    ResultData queryRegionCompany(String regionId);

    List<Company> serviceTypeStatistics(String statisticsType, String startDate, String endDate);
}
