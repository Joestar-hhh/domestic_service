package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.MyCollection;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.MycollectionService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/myCollectionContrller")
public class MyCollectionContrller {

    @Autowired
    private MycollectionService mycollectionService;

//查询我收藏的公司数据
    @RequestMapping("/selectMyCompany")
    public String selectMyCompany(HttpServletRequest request, HttpServletResponse response, MyCollection myCollection, String page, String limit) {
        ResultData resultData = mycollectionService.selectCompany(myCollection, Integer.parseInt(page), Integer.parseInt(limit),6);
        return JSON.toJSONString(resultData);
    }


    //删除服务列表数据
    @RequestMapping("/deleteServiceList")
    public String deleteServiceType(HttpServletRequest request, HttpServletResponse response,int id) {
        ResultData resultData=mycollectionService.deleteServiceList(id);
        return JSON.toJSONString(resultData);
    }



    //查询我收藏的服务数据
    @RequestMapping("/selectMyService")
    public String selectMyService(HttpServletRequest request, HttpServletResponse response, MyCollection myCollection, String page, String limit) {
        ResultData resultData = mycollectionService.selectCompany(myCollection, Integer.parseInt(page), Integer.parseInt(limit),6);
        return JSON.toJSONString(resultData);
    }


}
