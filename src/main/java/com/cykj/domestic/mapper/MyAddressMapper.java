package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.MyAddress;
import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface MyAddressMapper {


    int addAddress(MyAddress myAddress);

    //修改地址数据
    int updateAddress(MyAddress myAddress);

    //修改默认地址
    int updateDefultAddress(@Param("userid") int userid, @Param("id") int id);


    //删除地址数据
    int deleteAddress(int id);


//    List<MyAddress> selectDefaultAddress(@Param("e") MyAddress myAddress);

    //查询所有服务列表显示
    List<MyAddress> selectList(@Param("e") MyAddress myAddress,@Param("userid") int userid);
    int selectListCount(@Param("e") MyAddress myAddress);

    //根据用户地址id查询地址
    List<MyAddress> selectUseraddress(MyAddress myAddress);


}
