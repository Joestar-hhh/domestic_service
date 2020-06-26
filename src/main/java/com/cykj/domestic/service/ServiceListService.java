package com.cykj.domestic.service;


import com.cykj.domestic.entity.PriceRelation;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface ServiceListService {
    ResultData selectList(TbService tbService, int page, int pageSize);

    ResultData addServicelist(TbService tbService);

    ResultData updateServiceList(TbService tbService);

    ResultData deleteServiceList(int id);

    ResultData selectService();

    ResultData serviceListView(int id);

    //查询所有服务和服务类别
    ResultData queryServiceTypeName(int companyid,int page, int pageSize);

    ResultData updateServicePrice(PriceRelation priceRelation);

}
