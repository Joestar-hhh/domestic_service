package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.TrainPlan;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

//培训计划
@Repository
@Mapper
public interface TrainPlanMapper {

    //查询列表
    List<TrainPlan> queryTrainPlanList(@Param("e") TrainPlan trainPlan, @Param("start") int start, @Param("pageSize") int pageSize);

    //查询总数
    int queryTrainPlanCount(@Param("e") TrainPlan trainPlan);

    //删除计划
    int deletePlan(int id);

    //修改计划
    int updatePlan(TrainPlan trainPlan);

    //增加计划
    int insertPlan(TrainPlan trainPlan);
}
