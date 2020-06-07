package com.cykj.domestic.service;


import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface ServiceListService {
    ResultData selectList(TbService tbService, int page, int pageSize);
    int addServicelist(TbService tbService);
    int updateServiceList(TbService tbService);
    int deleteServiceList(int id);
}
