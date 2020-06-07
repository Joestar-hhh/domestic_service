package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.SkillTrain;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface TbSkillTrainMapper {

    //查询技能培训列表
    List<SkillTrain> querySkillTrain(@Param("start")int start, @Param("pageSize")int pageSize);

    //查询技能培训总数
    int querySkillTraincount();

    //查询4
    int deleteSkillTrain();



}
