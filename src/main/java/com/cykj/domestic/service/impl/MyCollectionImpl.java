package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.MyCollection;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.MyCollectionMapper;
import com.cykj.domestic.mapper.ServiceListMapper;
import com.cykj.domestic.service.MycollectionService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class MyCollectionImpl implements MycollectionService {

    @Autowired
    public MyCollectionMapper myCollectionMapper;


    //查询服务列表所有数据
    @Override
    public ResultData selectCompany(MyCollection myCollection, int page, int pageSize, int userid) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<MyCollection> list = myCollectionMapper.selectCompany(myCollection, start, pageSize,userid);
        int count = myCollectionMapper.selectCompanyCount(myCollection,userid);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(myCollection);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }
//收藏服务
    @Override
    public ResultData selectService(MyCollection myCollection, int page, int pageSize, int userid) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<MyCollection> list = myCollectionMapper.selectService(myCollection, start, pageSize,userid);
        int count = myCollectionMapper.selectServiceCount(myCollection,userid);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(myCollection);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }

    //删除服务列表数据
    @Override
    public ResultData deleteServiceList(int id) {
        int res= myCollectionMapper.deleteServiceList(id);
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




    //服务列表查看详情
    @Override
    public ResultData serviceListView(int id) {
        List<TbService> list = myCollectionMapper.serviceListView(id);
        System.out.println("list_______"+list);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
}
