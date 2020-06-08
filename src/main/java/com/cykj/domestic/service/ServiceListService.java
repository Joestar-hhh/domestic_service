package com.cykj.domestic.service;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface ServiceListService {
    ResultData selectList(TbService tbService, int page, int pageSize);
    ResultData addServicelist(TbService tbService);
//    ResultData updateServiceList(TbService tbService);
    ResultData deleteServiceList(int id);
    ResultData selectService();
}
