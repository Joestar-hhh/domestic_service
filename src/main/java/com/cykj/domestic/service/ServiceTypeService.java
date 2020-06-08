package com.cykj.domestic.service;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.util.ResultData;

public interface ServiceTypeService {
    ResultData selectList(ServiceType serviceType, int page, int pageSize);
    ResultData addServiceType(ServiceType serviceType);
    ResultData updateServiceType(ServiceType serviceType);
    ResultData deleteServiceType(int id);
}
