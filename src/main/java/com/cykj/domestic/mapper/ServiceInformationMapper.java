package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Information;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface ServiceInformationMapper {

    //所有服务信息显示
    List<Information> selectList(@Param("e") Information information, @Param("start") int start, @Param("pageSize") int pageSize);
    int selectListCount(@Param("e") Information information);


//    //查找所有服务类型
//    List<ServiceType> selectService();


    //服务信息查看详情
    List<Information>selectInformationListView(int id);


}
