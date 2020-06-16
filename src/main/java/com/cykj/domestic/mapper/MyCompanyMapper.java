package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface MyCompanyMapper {

    //修改公司信息数据
    int updateServiceList(Company company);
    //删除服务列表数据
    List<Company> selectList(@Param("e") Company company,@Param("userId")int userId);
//查询我的公司地址id
    int selectAddressId(@Param("regionName") String regionName);

    //修改我的公司ID
    int updateAddressID(@Param("regionId")int regionId,@Param("companyId")int companyId);
//
//    //删除公司关系表
//    int delectCompanyRelation(int companyId);

    //
//    int addServiceContinuous(int companyId);

}
