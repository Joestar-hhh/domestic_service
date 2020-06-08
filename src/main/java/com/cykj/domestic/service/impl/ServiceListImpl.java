package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Qualification;
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


    //查询服务列表所有数据
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


    //添加服务列表数据
    @Override
    public ResultData addServicelist(TbService tbService) {
        int res= serviceListMapper.addServiceList(tbService);
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


    //修改服务列表数据
    @Override
    public ResultData updateServiceList(TbService tbService) {
        int res= serviceListMapper.updateServiceList(tbService);
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




    //删除服务列表数据
    @Override
    public ResultData deleteServiceList(int id) {
        int res= serviceListMapper.deleteServiceList(id);
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


    //查找所有服务类型
    @Override
    public ResultData selectService() {
        List<ServiceType> list = serviceListMapper.selectService();
        System.out.println("list_______"+list);
        ResultData resultData = new ResultData();
//        resultData.setCode(0);
//        resultData.setMsg("删除成功");
        resultData.setData(list);
        return resultData;
    }
}
