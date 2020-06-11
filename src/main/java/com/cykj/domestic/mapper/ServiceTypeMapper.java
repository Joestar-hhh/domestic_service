package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ServiceTypeMapper {
    int addServiceType(ServiceType serviceType);

    int updateServiceType(ServiceType serviceType);

    List<ServiceType> selectList(@Param("e") ServiceType serviceType, @Param("start") int start, @Param("pageSize") int pageSize);

    int selectListCount(@Param("e") ServiceType serviceType);

    int deleteServiceType(int id);

    List<ServiceType> serviceTypeView(int id);


    /*公司端服务类别查询*/
    List<ServiceType> queryCompanyServiceType(@Param("id") String id, @Param("start") int start, @Param("pageSize") int pageSize);

    /*公司端服务类别查询统计*/
    int queryCompanyServiceTypeCount(String id);

    /*公司申请添加服务类别关系*/
    int addServicerelstion(ServiceType serviceType);

    /*查询所有服务类别*/
    List<ServiceType> queryServiceType();

}
