package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Database;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface DataBaseMapper {
    //添加服务列表数据
    int addServiceList(@Param("e")Database database,@Param("userid")int userid);

    List<Database>selectList(@Param("e") Database database, @Param("start") int start, @Param("pageSize") int pageSize, @Param("userid")int userid);
    int selectListCount(@Param("e") Database database,@Param("userid")int userid);
    //服务列表查看详情
    List<Database> serviceListView(@Param("e")Database database,@Param("userid")int userid);


    //人员资料
    //添加服务列表数据
    int addStaffList(@Param("e")Database database,@Param("userid")int userid);

    List<Database>selectStaffList(@Param("e") Database database, @Param("start") int start, @Param("pageSize") int pageSize, @Param("userid")int userid);
    int selectStaffListCount(@Param("e") Database database,@Param("userid")int userid);
    //服务列表查看详情
    List<Database> StaffListView(@Param("e")Database database,@Param("userid")int userid);

}
