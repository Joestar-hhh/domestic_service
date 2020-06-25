package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.ServiceEvaluation;
import com.cykj.domestic.entity.StaffEvaluation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Repository
@Mapper
public interface ServiceEvaluationMapper {

    List<ServiceEvaluation> queryServiceEvaluationList(@Param("e") ServiceEvaluation serviceEvaluation, @Param("start") int start, @Param("pageSize") int pageSize ,@Param("id")int id);

    int queryServiceEvaluationCount(@Param("e") ServiceEvaluation serviceEvaluation,@Param("id")int id);

    int updateContent(String content,String contentTime,int id);

//    用户添加评价（家政公司）
     int insertComEvaluation(ServiceEvaluation serviceEvaluation);
    //    用户添加评价（服务人员）
    int insertStaffEvaluation(StaffEvaluation staffEvaluation);
}
