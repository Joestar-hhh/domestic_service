package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Company;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
@Mapper
public interface CompanyMapper {

    List<Company> queryRegion();
}
