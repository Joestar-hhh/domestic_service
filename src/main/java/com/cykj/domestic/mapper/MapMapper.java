package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Mapper
@Repository
public interface MapMapper {

    ArrayList<Map> querymap();

//    查找所有父级地区
    List<Map>queryfirstLevelRegion();

//    查找次一级地区
    List<Map>querySecondaryZone(@Param("id")String id);



}
