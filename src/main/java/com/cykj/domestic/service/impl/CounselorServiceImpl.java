package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Counselor;
import com.cykj.domestic.entity.Role;
import com.cykj.domestic.mapper.CounselorMapper;
import com.cykj.domestic.service.CounselorService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CounselorServiceImpl implements CounselorService {

    @Autowired
    private CounselorMapper counselorMapper;

    @Override
    public ResultData queryCounselorList(Counselor counselor, int page, int limit) {

        List<Counselor> list = counselorMapper.queryCounselor(counselor,(page-1)*limit,limit);
        int count = counselorMapper.queryCounselorCount(counselor);

        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

}
