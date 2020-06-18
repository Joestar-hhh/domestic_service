package com.cykj.domestic.service;

import com.cykj.domestic.entity.User;
import com.cykj.domestic.util.ResultData;

import javax.servlet.http.HttpServletRequest;

public interface UserService {

    //查询用户默认地址
    ResultData queryUserAddress(User user);

    //用户登陆
    ResultData userLogin(User user, HttpServletRequest request);

    //用户注册
    ResultData insertUser(User user);

    //用户忘记加密码端修改密码
    ResultData phone_update_pwd(User user);

    //用户修改个人信息
    ResultData updateUserInfo(User user);
}
