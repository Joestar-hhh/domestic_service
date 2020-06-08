package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.mapper.ServiceTypeMapper;
import com.cykj.domestic.service.ServiceTypeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ServiceTypeImpl implements ServiceTypeService {

    @Autowired
    public ServiceTypeMapper serviceTypeMapper;

    @Override
    public ResultData selectList(ServiceType serviceType, int page, int pageSize) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<ServiceType> list = serviceTypeMapper.selectList(serviceType, start, pageSize);
        int count = serviceTypeMapper.selectListCount(serviceType);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(serviceType);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }

    @Override
    public ResultData addServiceType(ServiceType serviceType) {
        int res=serviceTypeMapper.addServiceType(serviceType);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;
    }

    @Override
    public ResultData updateServiceType(ServiceType serviceType) {
        int res = serviceTypeMapper.updateServiceType(serviceType);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }

    @Override
    public ResultData deleteServiceType(int id) {
        int res=serviceTypeMapper.deleteServiceType(id);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }
}
