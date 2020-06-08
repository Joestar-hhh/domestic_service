package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Company;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CompanyMapper {

    //平台端区域列表
    List<Company> queryRegion(@Param("start") int start, @Param("pageSize") int pageSize);

    //区域列表统计
    int RegionCount();

}
