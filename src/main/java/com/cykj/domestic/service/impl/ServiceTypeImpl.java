package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.mapper.CompanyMapper;
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

    @Autowired
    public CompanyMapper companyMapper;

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
        int res = serviceTypeMapper.addServiceType(serviceType);
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

    @Override
    public ResultData updateServiceType(ServiceType serviceType) {
        int res = serviceTypeMapper.updateServiceType(serviceType);
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

    @Override
    public ResultData deleteServiceType(int id) {
        int res = serviceTypeMapper.deleteServiceType(id);
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

    @Override
    public ResultData serviceTypeView(int id) {
        List<ServiceType> list = serviceTypeMapper.serviceTypeView(id);
        System.out.println("list_______" + list);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }

    //  公司申请入驻 添加服务服务类别
    @Override
    public ResultData addServiceContinuous(String menuIdList, String companyId, Company company) {
        List<String> list = JSON.parseArray(menuIdList, String.class);

        int i = companyMapper.insertregionId(companyId, String.valueOf(company.getRegionId()), company.getCompanyProfile(), company.getAddress());
        int res = serviceTypeMapper.addServiceContinuous(list, companyId, company);
        ResultData resultData = new ResultData();
        if (res >= 1) {
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;
    }

    /*公司端服务类别查询*/
    @Override
    public ResultData queryCompanyServiceType(String id, int page, int limit) {
        List<ServiceType> list = serviceTypeMapper.queryCompanyServiceType(id, (page - 1) * limit, limit);
        int count = serviceTypeMapper.queryCompanyServiceTypeCount(id);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    /*公司申请添加服务类别关系*/
    @Override
    public ResultData addServicerelstion(ServiceType serviceType) {
//        companyMapper.insertregionId();
        int res = serviceTypeMapper.addServicerelstion(serviceType);
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

    /*查询所有服务类别*/
    @Override
    public ResultData queryServiceType() {
        List<ServiceType> list = serviceTypeMapper.queryServiceType();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

    /*查询平台端审核服务类别*/
    @Override
    public ResultData querySericeTypeRelation(ServiceType serviceType, int page, int limit) {
        List<ServiceType> list = serviceTypeMapper.querySericeTypeRelation(serviceType, (page - 1) * limit, limit);
        int count = serviceTypeMapper.querySericeTypeRelationCount(serviceType);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    /* 平台修改公司端发送的服务类别申请变 审核通过*/
    @Override
    public ResultData updateSericeTypeRelation(ServiceType serviceType) {
        int res = serviceTypeMapper.updateSericeTypeRelation(serviceType);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("审核通过");
        } else {
            resultData.setCode(1);
            resultData.setMsg("审核失败");
        }
        return resultData;
    }

    /*查询所有服务*/
    @Override
    public ResultData selectSerice() {
        List<ServiceType> list = serviceTypeMapper.selectSerice();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

    /*查询前三的热门服务*/
    @Override
    public ResultData WXServiceTypeTopthree() {
        List<ServiceType> list = serviceTypeMapper.WXServiceTypeTopthree();
        ResultData resultData = new ResultData();
        for(ServiceType serviceType : list){
            serviceType.setUrl("/pages/index/type");
            serviceType.setIcon("/imgs/c.png");
        }
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

    /*查询所有未审核和Null的服务*/
    @Override
    public ResultData queryServiceNull(Company company) {
        List<ServiceType> list = serviceTypeMapper.queryServiceNull(company);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

    /*公司可以删除为审核的服务类别*/
    @Override
    public ResultData deleteCompanyRelation(String id) {
        int res=serviceTypeMapper.deleteCompanyRelation(id);
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

    @Override
    public List<ServiceType> queryComServiceType(int companyId) {
        return serviceTypeMapper.queryComServiceType(companyId);
    }

    @Override
    public List<TbService> queryServiceTypeService(int stID) {
        return serviceTypeMapper.queryServiceTypeService(stID);
    }

    @Override
    public List<TbService> queryStaffService(int staffId, int stId, String serviceIdList) {
        List<String> list = JSON.parseArray(serviceIdList,String.class);
        return serviceTypeMapper.queryStaffService(staffId,stId,list);
    }

    @Override
    public ResultData insertStaffService(int staffId, int stId, String list) {
        List<String> idList = JSON.parseArray(list,String.class);
        serviceTypeMapper.deleteStaffService(staffId,stId);
        int res = serviceTypeMapper.insertStaffService(staffId,stId,idList);
        ResultData resultData = new ResultData();
        if(res>=1){
            resultData.setCode(0);
            resultData.setMsg("修改员工服务成功！");
        }else {
            resultData.setCode(1);
            resultData.setMsg("修改员工服务失败！");
        }
        return resultData;
    }


    /*wx--查询所有服务类别*/
    @Override
    public ResultData queryServiceTypeWx() {
        List<ServiceType> list = serviceTypeMapper.queryServiceType();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

}
