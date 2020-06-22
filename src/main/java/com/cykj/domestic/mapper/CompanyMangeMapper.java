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
public interface CompanyMangeMapper {
    /**
     * 平台端家政公司管理入驻审核列表
     */
    List<Company> queryCompany(@Param("e")Company company,@Param("start") int start, @Param("pageSize") int pageSize,@Param("address")String address);

    /**
    入驻审核列表统计
     */
    int CompanyCount(@Param("e")Company company,@Param("address")String address);

    /**
     * 入驻审核
     */
    int checkJoin(Company company);

    // 根据服务查询公司
    List<Company> queryCompanyByService(@Param("e")Company company,@Param("start") int start, @Param("pageSize") int pageSize,@Param("typeName")String typeName);

    int countCompanyByService(@Param("e")Company company,@Param("typeName")String typeName);

    //查询公司已服务单数
    Company queryCompanyOrderNum(int companyId);

}
