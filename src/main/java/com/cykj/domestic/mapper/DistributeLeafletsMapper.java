package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.DistributeLeaflets;
import com.cykj.domestic.entity.PersonnelRating;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface DistributeLeafletsMapper {

    List<DistributeLeaflets> queryServiceEvaluationList(@Param("e") DistributeLeaflets distributeLeaflets, @Param("start") int start, @Param("pageSize") int pageSize, @Param("id") int id);

    int queryServiceEvaluationCount(@Param("e") DistributeLeaflets distributeLeaflets, @Param("id") int id);

    List<DistributeLeaflets> selectStaff(@Param("e") DistributeLeaflets distributeLeaflets, @Param("id") int id);

    int updatePaiDan(@Param("userId")int userId, @Param("id") int id);
}