package com.cykj.domestic.service;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;

public interface OrderService {

    ResultData queryOrderInfo(OrderInfo orderInfo, int page, int limit);
}
