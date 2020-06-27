package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.OrderInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface UserOrderMapper {
    //    添加用户发布需求和下订单
    int insertUserOrder(OrderInfo orderInfo);

    //   需求大厅
    List<OrderInfo> queryUserDemend(@Param("e")OrderInfo orderInfo,@Param("start") int start, @Param("pageSize") int pageSize );

    int queryUserDemendCount(@Param("e")OrderInfo orderInfo);


    //公司接单
    int updateUserDemend(OrderInfo orderInfo);

    //微信小程序用户查询自己发布的需求
    List<OrderInfo> WXUserQueryOrder(@Param("id") int id);

    //微信小程序删除用户发布的需求
    int WXdeleteOrderrequirement(OrderInfo orderInfo);


    //微信--用户下单
    int insertUserOrderInfo(OrderInfo orderInfo);

    //微信--支付成功 修改支付状态
    int updateOrderState(@Param("companyOrderState") String companyOrderState,
                         @Param("userOrderState") String userOrderState, @Param("orderNum") String orderNum);

}
