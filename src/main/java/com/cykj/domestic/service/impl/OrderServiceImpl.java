package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.OrderState;
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
//    订单统计
    @Override
    public List<OrderInfo> orderStatistics(String startDate, String endDate, String companyName) {
        List<OrderInfo> list = orderMapper.orderStatistics(startDate, endDate, companyName);
        return list;
    }

//    发布需求统计
    @Override
    public List<OrderInfo> requireStatistics(String startDate, String endDate) {
        List<OrderInfo> list = orderMapper.requireStatistics(startDate,endDate);
        return list;
    }
//售后追踪
    @Override
    public ResultData afterSaleList(OrderInfo orderInfo, int page, int limit,String orderNumber) {
        List<OrderInfo> list = orderMapper.afterSaleList(orderInfo, (page - 1) * limit, limit,orderNumber);
        int count = orderMapper.afterSaleCount(orderInfo);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }
//获取下拉框订单状态
    @Override
    public ResultData orderStatelist(OrderState orderState) {
        List<OrderState> list = orderMapper.orderStatelist(orderState);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
//家政公司订单管理
    @Override
    public ResultData companyOrderList(OrderInfo orderInfo, int page, int limit, String stateComName,String id) {
        List<OrderInfo> list = orderMapper.companyOrderList(orderInfo, (page - 1) * limit, limit,stateComName,id);
        int count = orderMapper.companyOrderCount(orderInfo,stateComName,id);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData orders(OrderInfo orderInfo) {
        int result=orderMapper.orders(orderInfo);
        ResultData resultData=new ResultData();
        if (result==1){
            resultData.setCode(0);
            resultData.setMsg("接单成功！");
        }else {
            resultData.setCode(1);
            resultData.setMsg("接单失败！");
        }
        return resultData;
    }

    @Override
    public List<OrderInfo> companyOrderStatistics(String startDate, String endDate) {
        List<OrderInfo> list = orderMapper.companyOrderStatistics(startDate,endDate);
        return list;
    }

    @Override
    public ResultData weChatOrderList(int userId) {
        List<OrderInfo>list=orderMapper.WeChatOrderList(userId);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }

}
