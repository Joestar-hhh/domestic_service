package com.cykj.domestic.service;


import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

import java.util.List;

public interface ServiceTypeService {
    ResultData selectList(ServiceType serviceType, int page, int pageSize);

    ResultData addServiceType(ServiceType serviceType);

    ResultData updateServiceType(ServiceType serviceType);

    ResultData deleteServiceType(int id);

    ResultData serviceTypeView(int id);


    //  公司申请入驻添加服务服务类别
    ResultData addServiceContinuous(String menuIdList, String companyId, Company company);

    /*公司端服务类别查询*/
    ResultData queryCompanyServiceType(String id, int page, int pageSize);

    /*公司申请添加服务类别关系*/
    ResultData addServicerelstion(ServiceType serviceType);

    /*查询所有服务类别*/
    ResultData queryServiceType();

    /*查询平台端审核服务类别*/
    ResultData querySericeTypeRelation(ServiceType serviceType, int page, int pageSize);

    /*平台修改公司端发送的服务类别申请变 审核通过*/
    ResultData updateSericeTypeRelation(ServiceType serviceType);

    /*查询所有服务*/
    ResultData selectSerice();

    /*查询前三的热门服务*/
    ResultData WXServiceTypeTopthree();

//    查询所有未审核和Null的服务
    ResultData queryServiceNull(Company company);

    /*公司可以删除为审核的服务类别*/
    ResultData deleteCompanyRelation(String id);


    //查询公司已有服务类别
    List<ServiceType> queryComServiceType(int companyId);
    //查询服务类别下的服务
    List<TbService> queryServiceTypeService(int stID);
    //员工已有服务
    List<TbService> queryStaffService(int staffId,int stId, String serviceIdList);

    //修改员工服务
    ResultData insertStaffService(int staffId,int stId, String list);

    //wx--查询所有服务类别
    ResultData queryServiceTypeWx();

    //微信端查询所有服务类别
    ResultData queryWXService(int serviceTypeId);

    //查询公司服务类别
    List<ServiceType> queryCompanyService(int companyId);

    List<TbService> queryCompanyHotService(int companyId);
}
