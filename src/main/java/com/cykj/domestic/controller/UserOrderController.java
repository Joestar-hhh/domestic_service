package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.service.UserOrderService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@RequestMapping("/userOrderController")
@RestController
public class UserOrderController {

    @Autowired
    private UserOrderService userOrderService;


    //--------------------------------------session  userid
    //用户发布需求
    @RequestMapping("/insertUserOrder")
    public String insertUserOrder(HttpServletResponse response, HttpServletRequest request, HttpSession session, OrderInfo orderInfo) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String newDate = sdf.format(new Date());
        String result = "";
        Random random = new Random();
        for (int i = 0; i < 3; i++) {
            result += random.nextInt(10);
        }
        System.out.println("订单号=" + "CY" + newDate + result);
        orderInfo.setOrderNumber("CY" + newDate + result);
        orderInfo.setUserOrderStateId(5);
        orderInfo.setUserId(2);
        ResultData resultData = userOrderService.insertUserOrder(orderInfo);
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
        orderInfo.setCompanyOrderStateId(1);
        orderInfo.setCompanyId(7);
        System.out.println(JSON.toJSONString(orderInfo));
       ResultData resultData= userOrderService.updateUserDemend(orderInfo);
        return JSON.toJSONString(resultData);
    }


}