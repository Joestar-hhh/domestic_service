package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.entity.Ticket;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface TicketMapper {

    int addServiceList(Ticket ticket);

    int updateServiceList(Ticket ticket);
    //删除服务列表数据
    int deleteServiceList(int id);
    //查询所有服务列表显示
    List<Ticket> selectList(@Param("e") Ticket ticket, @Param("start") int start, @Param("pageSize") int pageSize);
    int selectListCount(@Param("e") Ticket ticket);

    //小程序
    List<Ticket>selectListWx(@Param("e") Ticket ticket);
}
