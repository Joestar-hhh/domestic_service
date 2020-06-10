package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Counselor;
import com.cykj.domestic.entity.Staff;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

// 职位
@Repository
@Mapper
public interface OfficeMapper {

    //查询列表
    List<Staff> queryOfficeList(@Param("e")Staff staff, @Param("start") int start, @Param("pageSize") int pageSize);

    //查询总数
    int queryOfficeCount(@Param("e") Staff staff);

    //删除职位
    int deleteOffice(int id);

    //修改职位
    int updateOffice(Staff staff);

    //增加职位
    int insertOffice(Staff staff);

    //下拉框
    List<Counselor> counselorList();

}
