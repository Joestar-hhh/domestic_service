package com.cykj.domestic.service;


import com.cykj.domestic.entity.Information;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface ServiceInformationService {
    ResultData selectList(Information information, int page, int pageSize);
//    ResultData selectService();
    ResultData selectInformationListView(int id);
}
