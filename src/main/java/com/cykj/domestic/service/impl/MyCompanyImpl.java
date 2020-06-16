package com.cykj.domestic.service.impl;

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
    public ResultData updateMycompany(Company company,int id) {
        //修改公司表
        int res= myCompanyMapper.updateServiceList(id);
        //通过区域查出区域ID
        company.setRegionName(company.getFirstLevelRegion()+company.getSecondaryZone());
        Company company1 = myCompanyMapper.selectAddressId(company);
        //通过区域ID修改区域

        System.out.println("查询出要改为的公司区域id"+company1.getRegionId());
        int res2= myCompanyMapper.updateAddressID(company1.getRegionId());

        //删除公司服务类型关系表
        int res3=myCompanyMapper.delect(id);

        //
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("保存成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("保存失败");
        }
        return resultData;
    }





//    //删除公司类型表关系表
//    @Override
//    public ResultData delect(int id) {
//        int res= myCompanyMapper.delect(id);
////        ResultData resultData = new ResultData();
//        return null;
//    }
}
