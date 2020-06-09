package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Information;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.ServiceInformationService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/serviceInformationContrller")
public class ServiceInformationContrller {

    @Autowired
    private ServiceInformationService serviceInformationService;

//查询所有服务列表数据
    @RequestMapping("/selectInformationList")
    public String selectInformationList(HttpServletRequest request, HttpServletResponse response, Information information, String page, String limit) {
        ResultData resultData = serviceInformationService.selectList(information, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

//    //查询所有服务类型
//   @RequestMapping("/selectService")
//    public String selectService(HttpServletRequest request, HttpServletResponse response) {
//        ResultData resultData = serviceInformationService.selectService();
//        return JSON.toJSONString(resultData);
//    }


    //查询详情
    @RequestMapping("/selectInformationListView")
    public String selectInformationListView(HttpServletRequest request, HttpServletResponse response,int id) {
        ResultData resultData = serviceInformationService.selectInformationListView(id);
        return JSON.toJSONString(resultData);
    }

}
