package com.cykj.domestic.service;

import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.util.ResultData;

public interface ServicePersonnelratingService {

    ResultData queryServiceEvaluationList(PersonnelRating personnelRating, int page, int pageSize, int id);

    ResultData serviceListView(int userid,int id);

}
