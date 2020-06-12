package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface OrderMapper {

    List<OrderInfo> queryList(@Param("companyName") String companyName, @Param("start") int start, @Param("pageSize") int pageSize);

    int queryCount(@Param("companyName") String companyName);

    int deleteOrder(List<String> list);

    List<Company> queryCompanyList(Company company);
//        订单统计
    List<OrderInfo> orderStatistics(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("companyName") String companyName);

//   发布需求统计
    List<OrderInfo> requireStatistics(@Param("startDate") String startDate, @Param("endDate") String endDate);

//    售后追踪
    List<OrderInfo> afterSaleList( @Param("e")OrderInfo orderInfo,@Param("start") int start, @Param("pageSize") int pageSize,@Param("orderNumber")String orderNumber);

    int afterSaleCount(@Param("e")OrderInfo orderInfo);
}
