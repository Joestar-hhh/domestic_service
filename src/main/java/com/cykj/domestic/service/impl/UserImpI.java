package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.User;
import com.cykj.domestic.mapper.UserMapper;
import com.cykj.domestic.service.UserService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserImpI implements UserService {

    @Autowired
    private UserMapper userMapper;

    //查询用户默认地址
    @Override
    public ResultData queryUserAddress(User user) {
        List<User> list = userMapper.queryUserAddress(user);
        ResultData resultData = new ResultData();
        resultData.setData(list);
        return resultData;
    }
}
