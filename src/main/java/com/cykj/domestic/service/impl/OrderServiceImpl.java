package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
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
    public ResultData queryOrderInfo(String companyName, int page, int limit) {
        List<OrderInfo> list = orderMapper.queryList(companyName, (page - 1) * limit, limit);
        int count = orderMapper.queryCount(companyName);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData deleteOrder(String idList) {
        List<String> list = JSON.parseArray(idList, String.class);
        int res = orderMapper.deleteOrder(list);
        ResultData resultData = new ResultData();
        if (res >= 1) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }

    @Override
    public ResultData queryCompanyList(Company company) {
        List<Company> list = orderMapper.queryCompanyList(company);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }

    @Override
    public List<OrderInfo> orderStatistics(String startDate, String endDate, String companyName) {
        List<OrderInfo> list = orderMapper.orderStatistics(startDate, endDate, companyName);
        return list;
    }
}
