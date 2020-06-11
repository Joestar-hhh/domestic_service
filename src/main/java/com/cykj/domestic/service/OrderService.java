package com.cykj.domestic.service;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.util.ResultData;
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
}
