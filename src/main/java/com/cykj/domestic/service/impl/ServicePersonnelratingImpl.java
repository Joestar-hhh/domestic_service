package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.PersonnelratingMapper;
import com.cykj.domestic.mapper.ServiceEvaluationMapper;
import com.cykj.domestic.service.ServiceEvaluationService;
import com.cykj.domestic.service.ServicePersonnelratingService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServicePersonnelratingImpl implements ServicePersonnelratingService {

    @Autowired
    private PersonnelratingMapper personnelratingMapper;

    //查询服务列表所有数据
    @Override
    public ResultData queryServiceEvaluationList(PersonnelRating personnelRating, int page, int pageSize,int id) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<PersonnelRating> list = personnelratingMapper.queryServiceEvaluationList(personnelRating, start, pageSize,id);
        int count = personnelratingMapper.queryServiceEvaluationCount(personnelRating,id);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(personnelRating);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }
    //服务列表查看详情
    @Override
    public ResultData serviceListView(int userid,int id) {
        List<PersonnelRating> list = personnelratingMapper.serviceListView(userid,id);
        System.out.println("list_______" + list);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }

}
