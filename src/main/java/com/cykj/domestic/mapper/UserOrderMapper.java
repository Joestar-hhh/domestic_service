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



}
