package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Qualification;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface ServiceListMapper {
    //添加服务列表数据
    int addServiceList(TbService tbService);
    //修改服务列表数据
    int updateServiceList(TbService tbService);
    //删除服务列表数据
    int deleteServiceList(int id);
    //查询所有服务列表显示
    List<TbService> selectList(@Param("e") TbService tbService, @Param("start") int start, @Param("pageSize") int pageSize);
    int selectListCount(@Param("e") TbService tbService);
    //查找所有服务类型
    List<ServiceType> selectService();
    //服务列表查看详情
    List<TbService> serviceListView(int id);


}
