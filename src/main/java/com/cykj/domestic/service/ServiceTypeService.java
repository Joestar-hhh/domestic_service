package com.cykj.domestic.service;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.util.ResultData;

public interface ServiceTypeService {
    ResultData selectList(ServiceType serviceType, int page, int pageSize);
    int addServiceType(ServiceType serviceType);
    int updateServiceType(ServiceType serviceType);
    int deleteServiceType(int id);
}
