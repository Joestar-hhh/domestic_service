package com.cykj.domestic.service;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.util.ResultData;

public interface UserOrderService {

    //    添加用户发布需求和下订单
    ResultData insertUserOrder(OrderInfo orderInfo);

    //  需 求大厅
    ResultData queryUserDemend(OrderInfo orderInfo, int page, int limit);

    //公司接单

    ResultData updateUserDemend(OrderInfo orderInfo);






}
