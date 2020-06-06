package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Counselor;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CounselorMapper {

    List<Counselor> queryCounselor(@Param("e") Counselor counselor, @Param("start") int start, @Param("pageSize") int pageSize);

    int queryCounselorCount(@Param("e") Counselor counselor);

}
