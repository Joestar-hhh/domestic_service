package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Qualification;
import com.cykj.domestic.entity.SkillTrain;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface SkillTrainMapper {

    //查询技能培训列表
    List<SkillTrain> querySkillTrain(@Param("start") int start, @Param("pageSize") int pageSize);

    //查询技能培训总数
    int querySkillTraincount();

    //    删除
    int deleteSkillTrain(@Param("id") String id);

    //查找所有技能证书
    List<Qualification> queryqualification();

    //修改技能培训
    int updateSkillTrain(SkillTrain skillTrain);

    //添加技能培训
    int insertSkillTrain(SkillTrain skillTrain);


}
