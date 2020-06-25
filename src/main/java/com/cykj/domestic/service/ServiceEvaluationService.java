package com.cykj.domestic.service;

import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.entity.StaffEvaluation;
import com.cykj.domestic.util.ResultData;

public interface ServiceEvaluationService {

    ResultData queryServiceEvaluationList(ServiceEvaluation serviceEvaluation, int page, int limit ,int id);

    ResultData updateContent(String content,String contentTime,int id);

//    用户添加评价（家政公司）
    ResultData insertEvaluation(ServiceEvaluation serviceEvaluation,StaffEvaluation staffEvaluation);
//    用户添加评价（服务人员）
//    ResultData insertStaffEvaluation(StaffEvaluation staffEvaluation);

}
