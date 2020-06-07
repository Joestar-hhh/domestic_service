package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.ServiceListMapper;
import com.cykj.domestic.mapper.ServiceTypeMapper;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.service.ServiceTypeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ServiceListImpl implements ServiceListService {

    @Autowired
    public ServiceListMapper serviceListMapper;

    @Override
    public ResultData selectList(TbService tbService, int page, int pageSize) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<TbService> list = serviceListMapper.selectList(tbService, start, pageSize);
        int count = serviceListMapper.selectListCount(tbService);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(tbService);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }

    @Override
    public int addServicelist(TbService tbService) { return serviceListMapper.addServiceList(tbService);
    }

    @Override
    public int updateServiceList(TbService tbService) {
        return serviceListMapper.updateServiceList(tbService);
    }

    @Override
    public int deleteServiceList(int id) {
        return serviceListMapper.deleteServiceList(id);
    }
}
