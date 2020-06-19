package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.CompanyAccount;
import com.cykj.domestic.entity.Database;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface CompanyAccountMapper {


    List<CompanyAccount>selectList(@Param("e") CompanyAccount companyAccount, @Param("start") int start, @Param("pageSize") int pageSize, @Param("userid") int userid);


    List<CompanyAccount>selectbalance(@Param("e") CompanyAccount companyAccount, @Param("userid") int userid);
    int selectListCount(@Param("e") CompanyAccount companyAccount, @Param("userid") int userid);
}
