package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.MyCompanyMapper;
import com.cykj.domestic.mapper.ServiceListMapper;
import com.cykj.domestic.service.MyCompanyService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class MyCompanyImpl implements MyCompanyService {

    @Autowired
    public MyCompanyMapper myCompanyMapper;

    //查询公司数据
    @Override
    public ResultData selectList(Company company,int userId) {
//        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<Company> list = myCompanyMapper.selectList(company,userId);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
//            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(company);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }




    //修改我的公司信息数据
    @Override
    public ResultData updateMycompany(Company company) {
        //修改公司表
        int res= myCompanyMapper.updateServiceList(company);
        //通过区域查出区域ID
        company.setRegionName(company.getFirstLevelRegion()+company.getSecondaryZone());
        System.out.println("区域：---------------------"+company.getRegionName());
        int regionId = myCompanyMapper.selectAddressId(company.getRegionName());
        System.out.println("查询得id--------------------"+regionId);
        company.setRegionId(regionId);
        //通过区域ID修改区域

        System.out.println("查询出要改为的公司区域id"+company.getRegionId());
        int res2= myCompanyMapper.updateAddressID(company.getRegionId(),company.getId());

        //删除公司服务类型关系表
//        int res3=myCompanyMapper.delectCompanyRelation(company.getId());
//        List<String> list = JSON.parseArray(serviceTypeList,String.class);
//        int insertRes = myCompanyMapper.addServiceContinuous(company.getId());
        ResultData resultData = new ResultData();
        if(res2>=1){
            resultData.setCode(0);
            resultData.setMsg("保存成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("保存失败");
        }
        return resultData;
    }

    //添加公司类型

}
