package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.Role;
import com.cykj.domestic.mapper.OrderMapper;
import com.cykj.domestic.service.OrderService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public ResultData queryOrderInfo(OrderInfo orderInfo, int page, int limit) {
        List<OrderInfo> list = orderMapper.queryList(orderInfo,(page-1)*limit,limit);
        int count = orderMapper.queryCount(orderInfo);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }
}