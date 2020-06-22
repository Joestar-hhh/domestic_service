package com.cykj.domestic.service;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.util.ResultData;

public interface UserOrderService {

    //    添加用户发布需求和下订单
    ResultData insertUserOrder(OrderInfo orderInfo, User user);

    //  需 求大厅
    ResultData queryUserDemend(OrderInfo orderInfo, int page, int limit);

    //公司接单
    ResultData updateUserDemend(OrderInfo orderInfo);

   //微信小程序用户查询自己发布的需求
    ResultData WXUserQueryOrder(int id);

   //微信小程序删除用户发布的需求/
    ResultData WXdeleteOrderrequirement(OrderInfo orderInfo);


}
