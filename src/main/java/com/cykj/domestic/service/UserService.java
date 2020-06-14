package com.cykj.domestic.service;

import com.cykj.domestic.entity.User;
import com.cykj.domestic.util.ResultData;

public interface UserService {

    //查询用户默认地址
    ResultData queryUserAddress(User user);
}
