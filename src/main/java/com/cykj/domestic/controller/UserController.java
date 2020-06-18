package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.service.UserService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/userController")
@RestController
public class UserController {

    @Autowired
    private UserService userService;

    //查询用户默认地址
    @RequestMapping("/queryUserAddress")
    public String queryUserAddress(HttpServletResponse response, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        ResultData resultData = userService.queryUserAddress(user);
        return JSON.toJSONString(resultData);
    }

    //用户
    @RequestMapping("/userLogin")
    public String userLogin(HttpServletResponse response, HttpServletRequest request, User user) {
        ResultData resultData = userService.userLogin(user, request);
        return JSON.toJSONString(resultData);
    }

    //微信登录测试
    @RequestMapping("/weChatLogin")
    public String weChatLogin(HttpServletRequest request, String username,String pwd) {
        System.out.println("微信----账号："+username+"    密码："+pwd);
        User user = new User();
        user.setAccount(username);
        user.setPwd(pwd);
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

    /*用户注册*/
    @RequestMapping("/insertUser")
    public String insertCompany(HttpServletRequest request, HttpServletResponse response, User user) {
        ResultData resultData = userService.insertUser(user);
        return JSON.toJSONString(resultData);
    }

    //用户忘记密码修改密码
    @RequestMapping("/phone_update_pwd")
    public String phone_update_pwd(HttpServletRequest request, HttpServletResponse response, User user) {
        ResultData resultData = userService.phone_update_pwd(user);
        return JSON.toJSONString(resultData);
    }

    @RequestMapping("/updateUserInfo")
    public String updateUserInfo(User user) {
        ResultData resultData = userService.updateUserInfo(user);
        return JSON.toJSONString(resultData);
    }
}
