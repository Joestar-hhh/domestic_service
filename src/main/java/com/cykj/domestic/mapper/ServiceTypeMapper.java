package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

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


    //      <!--    公司申请入驻添加服务服务类别-->
    int addServiceContinuous(List<String> list, @Param("companyId") String companyId, Company company);


    /*查询所有服务类别*/
    List<ServiceType> queryServiceType();

    /*查询平台端审核服务类别*/
    List<ServiceType> querySericeTypeRelation(@Param("e") ServiceType serviceType, @Param("start") int start, @Param("pageSize") int pageSize);

    int querySericeTypeRelationCount(@Param("e") ServiceType serviceType);

    /*平台修改公司端发送的服务类别申请变 审核通过*/
    int updateSericeTypeRelation(ServiceType serviceType);

    /*查询所有服务*/
    List<ServiceType>selectSerice();

    /*查询前三的热门服务*/
    List<ServiceType> WXServiceTypeTopthree();

//    查询所有未审核和Null的服务
    List<ServiceType>queryServiceNull(Company company);

//    公司可以删除为审核的服务类别
    int deleteCompanyRelation(String id);


    List<ServiceType> queryComServiceType(int companyId);

    List<TbService> queryServiceTypeService(int stId);

    List<TbService> queryStaffService(@Param("staffId") int staffId, @Param("stId") int stId, List<String> list);


    int insertStaffService(@Param("staffId") int staffId, @Param("stId") int stId, List<String> list);

    int deleteStaffService(@Param("staffId") int staffId, @Param("stId") int stId);

    //微信端查询所有服务类别
    List<TbService> queryWXService(int serviceTypeId);


    //查询公司服务类型
    List<ServiceType> queryCompanyService(int companyId);
    //查询公司前3热门服务
    List<TbService> queryCompanyHotService(int companyId);

}
