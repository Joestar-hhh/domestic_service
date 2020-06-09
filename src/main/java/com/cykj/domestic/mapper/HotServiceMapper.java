package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface HotServiceMapper {

    //查询所有服务列表显示
    List<TbService> hotServiceQuery(@Param("e") TbService tbService, @Param("start") int start, @Param("pageSize") int pageSize);
    int selectListCount(@Param("e") TbService tbService);



}
