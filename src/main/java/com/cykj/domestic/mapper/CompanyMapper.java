package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.Region;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CompanyMapper {

     //    平台端登入
    Company companyLogin(Company company);

    //平台端区域列表
    List<Company> queryRegion(@Param("start") int start, @Param("pageSize") int pageSize);

    //区域列表统计
    int RegionCount();

    //删除区域
    int deleteRegion(@Param("region") String region);

    //查询区域是否存在
    Region selectRegionPresence(@Param("region") String region);

    //添加区域
    int insertRegion(@Param("region") String region);

//    根据地区查看平台详情
    List<Company>queryRegionCompany(@Param("regionId") String regionId);
//    家政公司统计
    List<Company> serviceTypeStatistics();
    List<Company> regionStatistics();
    List<Company> dateStatistics(@Param("startDate") String startDate, @Param("endDate") String endDate);
}
