package com.cykj.domestic.service;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.util.ResultData;

public interface ServiceTypeService {
    ResultData selectList(ServiceType serviceType, int page, int pageSize);
    ResultData addServiceType(ServiceType serviceType);
    ResultData updateServiceType(ServiceType serviceType);
    ResultData deleteServiceType(int id);
    ResultData serviceTypeView(int id);

    /*公司端服务类别查询*/
    ResultData queryCompanyServiceType(String id,int page, int pageSize);

    /*公司申请添加服务类别关系*/
    ResultData addServicerelstion(ServiceType serviceType);

    /*查询所有服务类别*/
    ResultData queryServiceType();
}
