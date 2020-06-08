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

    int addServiceList(TbService tbService);
//    int addServiceType(ServiceType serviceType);
    int updateServiceList(TbService tbService);
    int deleteServiceList(int id);
    //服务类型列表显示
    List<TbService> selectList(@Param("e") TbService tbService, @Param("start") int start, @Param("pageSize") int pageSize);
    int selectListCount(@Param("e") TbService tbService);
    //查找所有服务类型
    List<ServiceType> selectService();


}
