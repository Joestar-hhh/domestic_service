package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.DistributeLeaflets;
import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.DistributeLeafletsMapper;
import com.cykj.domestic.mapper.PersonnelratingMapper;
import com.cykj.domestic.service.DistributeLeafletsService;
import com.cykj.domestic.service.ServicePersonnelratingService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DistributeLeafletsImpl implements DistributeLeafletsService {

    @Autowired
    private DistributeLeafletsMapper distributeLeafletsMapper;

    //查询服务列表所有数据
    @Override
    public ResultData queryServiceEvaluationList(DistributeLeaflets distributeLeaflets, int page, int pageSize, int id) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<DistributeLeaflets> list = distributeLeafletsMapper.queryServiceEvaluationList(distributeLeaflets, start, pageSize,id);
        int count = distributeLeafletsMapper.queryServiceEvaluationCount(distributeLeaflets,id);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(distributeLeaflets);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }

    @Override
    public ResultData selectStaff(DistributeLeaflets distributeLeaflets, int id) {
        List<DistributeLeaflets> list = distributeLeafletsMapper.selectStaff(distributeLeaflets,id);
        System.out.println("list_______"+list);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }

    @Override
    public ResultData updatePaiDan(int userId, int id) {
        int res = distributeLeafletsMapper.updatePaiDan(userId,id);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("派单成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("无单可派");
        }
        return resultData;
    }


}
