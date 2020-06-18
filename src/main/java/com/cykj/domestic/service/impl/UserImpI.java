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
            System.out.println("用户-----" + user.getPwd() + "密码二-" + user1.getPwd());
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

    @Override
    public ResultData insertUser(User user) {
        ResultData resultData = new ResultData();
//        判断账号和手机号是否纯在
        User userphone = userMapper.queryUserPhone(user);
        if (userphone == null) {

            //创建账号
            String account = userMapper.MaxAccount();
            int i = Integer.parseInt(account) + 1;
            if (account.isEmpty() || account == null) {
                user.setAccount("10001");
            } else {
                user.setAccount(String.valueOf(i));
            }
            user.setPwd(MD5Util.MakeMd5(user.getPwd()));
            int res = userMapper.insertUser(user);
            if (res == 1) {
                resultData.setCode(0);
                resultData.setMsg("注册成功,请牢记您的账号密码：账号 " + i);
            } else {
                resultData.setCode(1);
                resultData.setMsg("注册失败");
            }
        } else {
            resultData.setCode(3);
            resultData.setMsg("手机号已被注册");
        }
        return resultData;

    }

    @Override
    public ResultData phone_update_pwd(User user) {
        ResultData resultData = new ResultData();
        User userPhone = userMapper.queryUserPhone(user);
        if (userPhone == null) {
            resultData.setCode(3);
            resultData.setMsg("手机号码不存在，请重新输入");
        } else {
            user.setPwd(MD5Util.MakeMd5(user.getPwd()));
            int res = userMapper.phone_update_pwd(user);
            if (res == 1) {
                resultData.setCode(0);
                resultData.setMsg("修改成功");
            } else {
                resultData.setCode(1);
                resultData.setMsg("修改失败");
            }
        }
        return resultData;
    }

    @Override
    public ResultData updateUserInfo(User user) {
        ResultData resultData = new ResultData();
        int res = userMapper.updateUserInfo(user);
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }

    @Override
    public ResultData uploadAvatar(User user) {
        ResultData resultData = new ResultData();
        int res = userMapper.uploadAvatar(user);
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("上传头像成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("上传头像失败");
        }
        return resultData;
    }
}
