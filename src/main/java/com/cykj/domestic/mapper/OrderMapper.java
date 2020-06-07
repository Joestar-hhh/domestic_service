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

    List<OrderInfo> queryList(@Param("e") OrderInfo orderInfo, @Param("start")int start, @Param("pageSize")int pageSize);
    int queryCount(@Param("e") OrderInfo orderInfo);
}
