package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Knowledge;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface KnowledgeMapper {

    List<Knowledge> queryKnowledeg(@Param("title") String title,@Param("start")int start, @Param("pageSize")int pageSize);

    int KnowledegCount(@Param("title") String title);

    int deleteKnowledeg(List<String> list);

    int addKnowledeg(Knowledge knowledge);

//<!--    增加育婴知识-->
    int addKnowledegStyle(Knowledge knowledge);

    int updateknowledeg(Knowledge knowledge);

//    获取育婴知识路径-
    List<Knowledge> queryKnowledegStyle(Knowledge knowledge);

    //微信查询育婴知识
    List<Knowledge> wxqueryknowledge();



}
