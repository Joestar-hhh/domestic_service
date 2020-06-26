package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface PersonnelratingMapper {

    List<PersonnelRating> queryServiceEvaluationList(@Param("e") PersonnelRating personnelRating, @Param("start") int start, @Param("pageSize") int pageSize, @Param("id") int id);

    int queryServiceEvaluationCount(@Param("e") PersonnelRating personnelRating, @Param("id") int id);

    //评价查看详情
    List<PersonnelRating> serviceListView(@Param("userid") int userid,@Param("id") int id);
}