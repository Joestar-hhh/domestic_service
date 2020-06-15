package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface UserMapper {
    //查询用户默认地址
    List<User> queryUserAddress(User user);

}
