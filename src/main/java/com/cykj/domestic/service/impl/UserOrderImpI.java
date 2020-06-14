package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.mapper.UserOrderMapper;
import com.cykj.domestic.service.UserOrderService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserOrderImpI implements UserOrderService {

    @Autowired
    private UserOrderMapper userOrderMapper;

    @Override
    public ResultData insertUserOrder(OrderInfo orderInfo) {
        int res = userOrderMapper.insertUserOrder(orderInfo);
        ResultData resultData = new ResultData();
        if (res > 0) {
            resultData.setCode(0);
            resultData.setMsg("发布成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("发布失败");
        }
        return resultData;

    }
    //查看所有未接单的订单-
    @Override
    public ResultData queryUserdemand() {
        List<OrderInfo> list = userOrderMapper.queryUserdemand();
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
}
