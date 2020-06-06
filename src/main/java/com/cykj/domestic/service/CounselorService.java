package com.cykj.domestic.service;

import com.cykj.domestic.entity.Counselor;
import com.cykj.domestic.util.ResultData;

public interface CounselorService {

    ResultData queryCounselorList(Counselor counselor, int page, int limit);
}
