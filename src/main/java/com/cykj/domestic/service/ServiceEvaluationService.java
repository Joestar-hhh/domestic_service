package com.cykj.domestic.service;

import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.util.ResultData;

public interface ServiceEvaluationService {

    ResultData queryServiceEvaluationList(ServiceEvaluation serviceEvaluation, int page, int limit);

    ResultData updateContent(String content,String contentTime,int id);

}
