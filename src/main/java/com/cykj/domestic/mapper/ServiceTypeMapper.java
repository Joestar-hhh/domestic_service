package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.ServiceType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ServiceTypeMapper {
    int addServiceType(ServiceType serviceType);
    int updateServiceType(ServiceType serviceType);
    List<ServiceType> selectList(@Param("e") ServiceType serviceType, @Param("start") int start, @Param("pageSize") int pageSize);
    int selectListCount(@Param("e") ServiceType serviceType);
    int deleteServiceType(int id);

}
