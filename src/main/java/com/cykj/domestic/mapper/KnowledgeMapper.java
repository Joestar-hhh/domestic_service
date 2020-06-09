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



}
