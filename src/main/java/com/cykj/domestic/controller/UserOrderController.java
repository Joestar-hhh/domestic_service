package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.service.UserOrderService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RequestMapping("/userOrderController")
@RestController
public class UserOrderController {

    @Autowired
    private UserOrderService userOrderService;


    //--------------------------------------session  userid
    //用户发布需求
    @RequestMapping("/insertUserOrder")
    public String insertUserOrder(HttpServletResponse response, HttpServletRequest request, HttpSession session, OrderInfo orderInfo) {
        User user = (User) request.getSession().getAttribute("user");
        ResultData resultData = userOrderService.insertUserOrder(orderInfo,user);
        return JSON.toJSONString(resultData);

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
    public String updateUserDemend(HttpServletRequest request, HttpServletResponse response, OrderInfo orderInfo, HttpSession session) {
        orderInfo.setCompanyOrderStateId(2);
        orderInfo.setUserOrderStateId(6);
        orderInfo.setCompanyId(7);
        System.out.println(JSON.toJSONString(orderInfo));
       ResultData resultData= userOrderService.updateUserDemend(orderInfo);
        return JSON.toJSONString(resultData);
    }


}