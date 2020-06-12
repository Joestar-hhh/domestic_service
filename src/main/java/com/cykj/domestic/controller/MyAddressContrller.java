package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.MyAddress;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.MyAddressService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/myAddressContrller")
public class MyAddressContrller {

    @Autowired
    private MyAddressService myAddressService;

//查询所有服务列表数据
    @RequestMapping("/selectAddress")
    public String selectServiceList(HttpServletRequest request, HttpServletResponse response, MyAddress myAddress, String page, String limit) {
        ResultData resultData = myAddressService.selectList(myAddress, Integer.parseInt(page), Integer.parseInt(limit) ,6);
        return JSON.toJSONString(resultData);
    }


    //添加服务列表数据
    @RequestMapping("/addAddress")
    public String addServiceList2(HttpServletRequest request, HttpServletResponse response, MyAddress myAddress) {
        System.out.println(JSON.toJSONString(myAddress));
        ResultData resultData=myAddressService.addAddress(myAddress);
        return JSON.toJSONString(resultData);
    }


    //修改服务列表数据
    @RequestMapping("/updateAddress")
    public String updateServiceType(HttpServletRequest request, HttpServletResponse response, MyAddress myAddress) {
        ResultData resultData=myAddressService.updateAddress(myAddress);
        return JSON.toJSONString(resultData);
    }



    //删除服务列表数据
    @RequestMapping("/deleteAddress")
    public String deleteServiceType(HttpServletRequest request, HttpServletResponse response,int id) {
        ResultData resultData=myAddressService.deleteAddress(id);
        return JSON.toJSONString(resultData);
    }

    //修改默认地址
    @RequestMapping("/updateDefultAddress")
    public String updateDefultAddress(HttpServletRequest request, HttpServletResponse response,int id) {
        ResultData resultData=myAddressService.updateDefultAddress(6,id);
        return JSON.toJSONString(resultData);
    }

}