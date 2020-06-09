package com.cykj.domestic.service;

import com.cykj.domestic.entity.Counselor;
import com.cykj.domestic.entity.TrainPlan;
import com.cykj.domestic.util.ResultData;

public interface CounselorService {

    ResultData queryCounselorList(Counselor counselor, int page, int limit);

    //删除计划
    ResultData deleteCounselor(int id);

    //修改计划
    ResultData updateCounselor(Counselor counselor);

    //增加计划
    ResultData insertCounselor(Counselor counselor);
}
