package com.cykj.domestic.service;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.util.ResultData;

public interface UserOrderService {

//    添加用户发布需求和下订单
    ResultData insertUserOrder(OrderInfo orderInfo);

    //查看所有未接单的订单-
    ResultData queryUserdemand();

}
