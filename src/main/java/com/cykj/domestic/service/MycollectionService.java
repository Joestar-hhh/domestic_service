package com.cykj.domestic.service;


import com.cykj.domestic.entity.MyCollection;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface MycollectionService {
    ResultData selectCompany(MyCollection myCollection, int page, int pageSize,int userid);

    ResultData selectService(MyCollection myCollection, int page, int pageSize,int userid);

    ResultData deleteServiceList(int id);
    ResultData serviceListView(int id);
}
