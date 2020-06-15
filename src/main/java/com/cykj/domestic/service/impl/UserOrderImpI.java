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

    //添加用户发布需求和下订单
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

    //需 求大厅
    @Override
    public ResultData queryUserDemend(OrderInfo orderInfo,int page, int limit) {
        List<OrderInfo> list = userOrderMapper.queryUserDemend(orderInfo,(page-1)*limit,limit);
        int count=userOrderMapper.queryUserDemendCount(orderInfo);
        ResultData resultData = new ResultData();
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

//    公司接单
    @Override
    public ResultData updateUserDemend(OrderInfo orderInfo) {
        int res=userOrderMapper.updateUserDemend(orderInfo);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("接单成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("接单失败");
        }
        return resultData;
    }

}
