package com.cykj.domestic.service;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.OrderState;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface OrderService {

    ResultData queryOrderInfo(String companyName, int page, int limit);

    ResultData deleteOrder(String idList);

    ResultData queryCompanyList(Company company);
//    订单统计
    List<OrderInfo> orderStatistics(String startDate, String endDate, String companyName);

//    发布需求统计
    List<OrderInfo> requireStatistics(String startDate, String endDate);

//    售后追踪
    ResultData afterSaleList(OrderInfo orderInfo,int page, int limit,String orderNumber);

    //获取下拉框订单状态
    ResultData orderStatelist(OrderState orderState);

//    家政公司订单管理
    ResultData companyOrderList(OrderInfo orderInfo,int page, int limit,String stateComName,String id);

    //接单
    ResultData orders(OrderInfo orderInfo);
}
