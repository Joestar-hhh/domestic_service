package com.cykj.domestic.service;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;

public interface OrderService {

    ResultData queryOrderInfo(String companyName, int page, int limit);

    ResultData deleteOrder(String idList);
}
