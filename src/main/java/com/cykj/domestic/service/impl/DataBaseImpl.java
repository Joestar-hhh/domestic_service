package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Database;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.DataBaseMapper;
import com.cykj.domestic.mapper.ServiceListMapper;
import com.cykj.domestic.service.DataBaseService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class DataBaseImpl implements DataBaseService {

    @Autowired
    public DataBaseMapper dataBaseMapper;


    //查询公司资料数据
    @Override
    public ResultData selectList(Database database, int page, int pageSize,int userid) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<Database> list = dataBaseMapper.selectList(database, start, pageSize,userid);
        int count = dataBaseMapper.selectListCount(database,userid);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(database);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }


    //添加凭证图片
    @Override
    public ResultData addServicelist(Database database,int userid) {
        int res= dataBaseMapper.addServiceList(database ,userid);
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


    //服务列表查看详情
    @Override
    public ResultData serviceListView( Database database,int userid) {
        List<Database> list = dataBaseMapper.serviceListView(database,userid);
        System.out.println("list_______"+list);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }



    //人员资料
    //查询公司资料数据
    @Override
    public ResultData selectStaff(Database database, int page, int pageSize,int userid) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<Database> list = dataBaseMapper.selectStaffList(database, start, pageSize,userid);
        int count = dataBaseMapper.selectStaffListCount(database,userid);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(database);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }


    //添加凭证图片
    @Override
    public ResultData addStafflist(Database database,int userid) {
        int res= dataBaseMapper.addStaffList(database ,userid);
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


    //服务列表查看详情
    @Override
    public ResultData StaffListView( Database database,int userid) {
        List<Database> list = dataBaseMapper.StaffListView(database,userid);
        System.out.println("list_______"+list);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
}
