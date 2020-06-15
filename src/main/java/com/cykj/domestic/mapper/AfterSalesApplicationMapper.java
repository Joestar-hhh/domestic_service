package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.AfterSalesApplication;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AfterSalesApplicationMapper {

    List<AfterSalesApplication> queryAfterSalesApplication(@Param("e") AfterSalesApplication afterSalesApplication, @Param("start") int start, @Param("pageSize") int pageSize, @Param("id") int id, @Param("orderNumber") String orderNumber);

    int queryAfterSalesApplicationCount(@Param("e") AfterSalesApplication afterSalesApplication, @Param("id") int id, @Param("orderNumber") String orderNumber);

    int passCheck(int id);

    int nopassCheck(int id);
}
