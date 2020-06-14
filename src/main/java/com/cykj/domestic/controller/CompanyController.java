package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.service.CompanySrevice;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/companyController")
public class CompanyController {

    @Autowired
    public CompanySrevice companySrevice;


    //家政公司端登入
    @RequestMapping("/companyLogin")
    public String companyLogin(HttpServletResponse response, HttpServletRequest request, Company company) {

        ResultData resultData = companySrevice.companyLogin(company, request);
//        System.out.println(JSON.toJSONString(resultData));
        return JSON.toJSONString(resultData);
    }

    //家政公司端修改密码
    @RequestMapping("/phone_update_pwd")
    public String phone_update_pwd(HttpServletRequest request, HttpServletResponse response, Company company) {
        ResultData resultData = companySrevice.phone_update_pwd(company);
        return JSON.toJSONString(resultData);
    }

    /*家政公司注册*/
    @RequestMapping("/insertCompany")
    public String insertCompany(HttpServletRequest request, HttpServletResponse response, Company company) {
//        System.out.println(JSON.toJSONString(company));
        ResultData resultData = companySrevice.insertCompany(company);
        return JSON.toJSONString(resultData);
//        return null;
    }


    //区域列表
    @ResponseBody
    @RequestMapping(value = "/queryRegion")
    public String queryRegion(HttpServletResponse response, HttpServletRequest request, String page, String limit) {
        ResultData resultData = companySrevice.queryRegion(Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }


    /* 查询平台所有服务区域*/
    @RequestMapping("/queryregionList")
    public String queryregionList() {
        ResultData resultData = companySrevice.queryregionList();
        return JSON.toJSONString(resultData);
    }


    //删除区域
    @ResponseBody
    @RequestMapping(value = "/deleteRegion")
    public String deleteRegion(HttpServletRequest request, HttpServletResponse response) {
        String region = request.getParameter("region");
        System.out.println(region);
        ResultData resultData = companySrevice.deleteRegion(region);
        return JSON.toJSONString(resultData);
    }

    //增加区域
    @ResponseBody
    @RequestMapping(value = "/insertRegion")
    public String insertRegion(HttpServletRequest request, HttpServletResponse response) {
        String firstLevelRegion = request.getParameter("firstLevelRegion");
        String secondaryZone = request.getParameter("secondaryZone");
        String region = firstLevelRegion + secondaryZone;
        System.out.println(region);
        ResultData resultData = companySrevice.selectRegionPresence(region);
        return JSON.toJSONString(resultData);
    }


    //    根据地区查看平台详情
    @ResponseBody
    @RequestMapping(value = "/queryRegionCompany")
    public String queryRegionCompany(HttpServletRequest request, HttpServletResponse response) {
        String regionId = request.getParameter("regionId");
        ResultData resultData = companySrevice.queryRegionCompany(regionId);
        return JSON.toJSONString(resultData);
    }


    //    根据服务类型统计公司数量
    @RequestMapping("/serviceStatistics")
    public String serviceStatistics(String statisticsType, String startDate, String endDate) {
        List<Company> list = companySrevice.serviceTypeStatistics(statisticsType, startDate, endDate);
        return JSON.toJSONString(list);
    }

    // 家政公司端退出登录
    @RequestMapping("/quit")
    public String remove(HttpServletRequest request) {
        request.getSession().invalidate();
        System.out.println("退出登录了>>>>>");
        return "1";
    }
}
