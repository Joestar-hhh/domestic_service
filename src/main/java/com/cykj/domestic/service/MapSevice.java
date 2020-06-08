package com.cykj.domestic.service;

import com.cykj.domestic.entity.Map;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public interface MapSevice {

    HashMap<String, ArrayList<Map>>querymap();

   //    查找所有父级地区
    ResultData queryfirstLevelRegion();

    //    查找次一级地区
    ResultData querySecondaryZone(String id);


}
