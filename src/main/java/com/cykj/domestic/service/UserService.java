package com.cykj.domestic.service;

import com.cykj.domestic.entity.User;
import com.cykj.domestic.util.ResultData;

import javax.servlet.http.HttpServletRequest;

public interface UserService {

    //查询用户默认地址
    ResultData queryUserAddress(User user);

    //用户登陆
    ResultData userLogin(User user, HttpServletRequest request);
}