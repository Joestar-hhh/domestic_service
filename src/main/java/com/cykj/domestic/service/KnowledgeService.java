package com.cykj.domestic.service;

import com.cykj.domestic.entity.Knowledge;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Param;


public interface KnowledgeService {

    ResultData queryKnowledeg(String title,int page, int limit);

    ResultData deleteKnowledeg(String idList);

    ResultData addKnowledeg(Knowledge knowledge);

    ResultData updateknowledeg(Knowledge knowledge);







}
