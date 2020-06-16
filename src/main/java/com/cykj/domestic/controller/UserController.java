package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.service.UserService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RequestMapping("/userController")
@RestController
public class UserController {

    @Autowired
    private UserService userService;

    //查询用户默认地址
    @RequestMapping("/queryUserAddress")
    public String queryUserAddress(HttpServletResponse response, HttpServletRequest request , HttpSession session){
        User user=new User();
        user.setUserAddressId(1);
        ResultData resultData=userService.queryUserAddress(user);
        return JSON.toJSONString(resultData);
    }

    //用户
    @RequestMapping("/userLogin")
    public String userLogin(HttpServletResponse response, HttpServletRequest request, User user) {
        ResultData resultData = userService.userLogin(user, request);
        return JSON.toJSONString(resultData);
    }

    // 用户退出登录
    @RequestMapping("/quit")
    public String remove(HttpServletRequest request) {
        request.getSession().invalidate();
        System.out.println("用户退出登录了！");
        return "1";
    }
}
