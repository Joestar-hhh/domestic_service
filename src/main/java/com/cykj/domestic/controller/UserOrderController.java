package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.service.UserOrderService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/userOrderController")
@RestController
public class UserOrderController {

    @Autowired
    private UserOrderService userOrderService;


    //--------------------------------------session  userid
    //用户发布需求
    @RequestMapping("/insertUserOrder")
    public String insertUserOrder(HttpServletResponse response, HttpServletRequest request,OrderInfo orderInfo) {
        ResultData resultData = userOrderService.insertUserOrder(orderInfo);
        return JSON.toJSONString(resultData);
//        System.out.println("微信发送的需求消息"+JSON.toJSONString(orderInfo));
//        return null;
    }

    //查看所有未接单的订单-
    @RequestMapping("/queryUserdemand")
    public String queryUserdemand(HttpServletRequest request, HttpServletResponse response, OrderInfo orderInfo, String page, String limit) {
        ResultData resultData = userOrderService.queryUserDemend(orderInfo, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    //--------------------------------------session  userid
    //接单
    @RequestMapping("/updateUserDemend")
    public String updateUserDemend(HttpServletRequest request, HttpServletResponse response, OrderInfo orderInfo) {
        Company company = (Company) request.getSession().getAttribute("company");
        orderInfo.setCompanyOrderStateId(2);
        orderInfo.setUserOrderStateId(6);
        orderInfo.setCompanyId(company.getId());
        System.out.println(JSON.toJSONString(orderInfo));
        ResultData resultData = userOrderService.updateUserDemend(orderInfo);
        return JSON.toJSONString(resultData);
    }

    //微信小程序用户查询自己发布的需求
    @RequestMapping("/WXUserQueryOrder")
    public String WXUserQueryOrder(HttpServletRequest request,HttpServletResponse response,User user){
//        user.setId(12);
        ResultData resultData=userOrderService.WXUserQueryOrder(12);
        return JSON.toJSONString(resultData);
    }

    //微信小程序删除需求
    @RequestMapping("/WXdeleteOrderrequirement")
    public String WXdeleteOrderrequirement(HttpServletRequest request,HttpServletResponse response,OrderInfo orderInfo){
        System.out.println("ss="+JSON.toJSONString(orderInfo));
        ResultData resultData=userOrderService.WXdeleteOrderrequirement(orderInfo);
        return JSON.toJSONString(resultData);
    }
}