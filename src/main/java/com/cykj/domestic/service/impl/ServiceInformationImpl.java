package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Information;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.ServiceInformationMapper;
import com.cykj.domestic.mapper.ServiceListMapper;
import com.cykj.domestic.service.ServiceInformationService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ServiceInformationImpl implements ServiceInformationService {

    @Autowired
    public ServiceInformationMapper serviceInformationMapper;


    //查询服务列表所有数据
    @Override
    public ResultData selectList(Information information, int page, int pageSize) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<Information> list = serviceInformationMapper.selectList(information, start, pageSize);
        int count = serviceInformationMapper.selectListCount(information);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(information);
            System.out.println("服务信息时间段查询得到的list"+list);
        } else {
            resultData.setCode(1);
            resultData.setMsg("无数据显示");
        }
        return resultData;
    }





//    //查找所有服务类型
//    @Override
//    public ResultData selectService() {
//        List<ServiceType> list = serviceInformationMapper.selectService();
//        ResultData resultData = new ResultData();
////        resultData.setCode(0);
////        resultData.setMsg("删除成功");
//        resultData.setData(list);
//        return resultData;
//    }
//    服务列表查看详情
    @Override
    public ResultData selectInformationListView(int id) {
        List<Information> list = serviceInformationMapper.selectInformationListView(id);
        System.out.println("list_______"+list);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
}
