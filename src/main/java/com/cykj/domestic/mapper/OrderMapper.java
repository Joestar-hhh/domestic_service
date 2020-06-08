package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface OrderMapper {

    List<OrderInfo> queryList(@Param("companyName") String companyName, @Param("start")int start, @Param("pageSize")int pageSize);
    int queryCount(@Param("companyName") String companyName);

    int deleteOrder(List<String> list);
}
