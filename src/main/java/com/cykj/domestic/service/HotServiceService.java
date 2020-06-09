package com.cykj.domestic.service;


import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface HotServiceService {
    ResultData hotServiceQuery(TbService tbService, int page, int pageSize);

}
