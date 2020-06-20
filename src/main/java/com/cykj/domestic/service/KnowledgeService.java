package com.cykj.domestic.service;

import com.cykj.domestic.entity.Knowledge;
import com.cykj.domestic.util.ResultData;


public interface KnowledgeService {

    ResultData queryKnowledeg(String title,int page, int limit);

    ResultData deleteKnowledeg(String idList);

    ResultData addKnowledeg(Knowledge knowledge);

    ResultData updateknowledeg(Knowledge knowledge);

//    获取育婴知识路径-
    ResultData queryKnowledegStyle(Knowledge knowledge);

    //<!--    增加育婴知识-->
    ResultData addKnowledegStyle(Knowledge knowledge);


    //微信查询育婴知识
    ResultData wxqueryknowledge();







}
