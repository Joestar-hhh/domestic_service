package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.MyAddress;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.MyAddressMapper;
import com.cykj.domestic.mapper.ServiceListMapper;
import com.cykj.domestic.service.MyAddressService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class MyAddressImpl implements MyAddressService {

    @Autowired
    public com.cykj.domestic.mapper.MyAddressMapper MyAddressMapper;


    //查询我的地址所有数据
    @Override
    public ResultData selectList(MyAddress myAddress, int userid) {
        List<MyAddress> list = MyAddressMapper.selectList(myAddress,userid);
        int count = MyAddressMapper.selectListCount(myAddress);
        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(myAddress);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }

    @Override
    public ResultData addAddress(MyAddress myAddress) {
        myAddress.setRegionName(myAddress.getFirstLevelRegion()+myAddress.getSecondaryZone());
        int res = MyAddressMapper.addAddress(myAddress);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;
    }


    //修改我的地址数据
    @Override
    public ResultData updateAddress(MyAddress myAddress) {
        int res = MyAddressMapper.updateAddress(myAddress);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }


    //删除我的地址数据
    @Override
    public ResultData deleteAddress(int id) {
        int res = MyAddressMapper.deleteAddress(id);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }

    //修改默认地址
    @Override
    public ResultData updateDefultAddress(int userid,int id) {
        int res = MyAddressMapper.updateDefultAddress(userid,id);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("修改默认地址成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改默认地址失败");
        }
        return resultData;
    }

}
