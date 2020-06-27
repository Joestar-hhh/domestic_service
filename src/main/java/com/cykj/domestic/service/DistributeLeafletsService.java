package com.cykj.domestic.service;

import com.cykj.domestic.entity.DistributeLeaflets;
import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface DistributeLeafletsService {

    ResultData queryServiceEvaluationList(DistributeLeaflets distributeLeaflets, int page, int pageSize, int id);


    ResultData selectStaff(DistributeLeaflets distributeLeaflets,int id);

    ResultData updatePaiDan(int userId,int id);
}
