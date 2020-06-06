package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Annoucement;
import com.cykj.domestic.mapper.AnnoucementMapper;
import com.cykj.domestic.service.AnnoucementService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AnnoucementServiceImpl implements AnnoucementService {

    @Autowired
    private AnnoucementMapper annoucementMapper;

    @Override
    public ResultData queryAnnoucementList(Annoucement annoucement, int page, int limit) {
        List<Annoucement> list=annoucementMapper.queryAnnoucement(annoucement,(page-1)*limit,limit);
        int count=annoucementMapper.queryAnnoucementCount(annoucement);

        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }
}
