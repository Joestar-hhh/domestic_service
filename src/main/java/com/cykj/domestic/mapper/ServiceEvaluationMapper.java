package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.ServiceEvaluation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ServiceEvaluationMapper {

    List<ServiceEvaluation> queryServiceEvaluationList(@Param("e") ServiceEvaluation serviceEvaluation, @Param("start") int start, @Param("pageSize") int pageSize);

    int queryServiceEvaluationCount(@Param("e") ServiceEvaluation serviceEvaluation);
}
