package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.OrderInfo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface UserOrderMapper {
    //    添加用户发布需求和下订单
    int insertUserOrder(OrderInfo orderInfo);

    //查看所有未接单的订单-
    List<OrderInfo> queryUserdemand();


}
