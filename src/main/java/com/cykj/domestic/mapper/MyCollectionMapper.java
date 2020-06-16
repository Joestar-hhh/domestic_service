package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.MyCollection;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface MyCollectionMapper {

    //删除服务列表数据
    int deleteServiceList(int id);

    //查询收藏公司显示
    List<MyCollection>selectCompany(@Param("e") MyCollection myCollection, @Param("start") int start, @Param("pageSize") int pageSize,int userid);
    int selectCompanyCount(@Param("e") MyCollection myCollection,@Param("userid" ) int userid);



    //查询收藏服务显示
    List<MyCollection>selectService(@Param("e") MyCollection myCollection, @Param("start") int start, @Param("pageSize") int pageSize,int userid);
    int selectServiceCount(@Param("e") MyCollection myCollection,@Param("userid" ) int userid);

    //服务列表查看详情
    List<TbService> serviceListView(int id);


}
