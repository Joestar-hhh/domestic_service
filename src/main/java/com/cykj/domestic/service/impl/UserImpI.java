package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.mapper.UserMapper;
import com.cykj.domestic.service.UserService;
import com.cykj.domestic.util.MD5Util;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
    //用户登陆
    @Override
    public ResultData userLogin(User user, HttpServletRequest request) {
        ResultData resultData = new ResultData();
        HttpSession session = request.getSession();
        User user1 = userMapper.userLogin(user);
        if (user1 != null) {
            System.out.println("用户-----"+user.getPwd()+"密码二-"+user1.getPwd());
                if (!MD5Util.MakeMd5(user.getPwd()).equals(user1.getPwd())) {
                    resultData.setCode(1);
                    resultData.setMsg("密码错误");
                } else {
                    session.setAttribute("user", user1);
                    resultData.setCode(0);
                    resultData.setMsg("登陆成功");

                }
        } else {
            resultData.setCode(2);
            resultData.setMsg("账号不存在，请先注册");
        }
        return resultData;
    }
}
