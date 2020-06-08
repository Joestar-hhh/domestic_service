package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.Role;
import com.cykj.domestic.service.OrderService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* 订单controller
*/
@RestController
@RequestMapping("/orderController")
public class OrderController {


    @Autowired
    private OrderService orderService;

    /*
     * 查询订单信息
     */
    @RequestMapping("/queryOrder")
    public String queryOrder(String companyName, String page, String limit){
        ResultData resultData =  orderService.queryOrderInfo(companyName, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    /*
     * 删除订单信息
     */
    @RequestMapping("/deleteOrder")
    public String deleteOrder(String idList){
        ResultData resultData = orderService.deleteOrder(idList);
        return JSON.toJSONString(resultData);
    }
}
