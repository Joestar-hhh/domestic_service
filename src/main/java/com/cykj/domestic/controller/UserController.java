package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cykj.domestic.entity.Database;
import com.cykj.domestic.entity.User;
import com.cykj.domestic.service.UserService;
import com.cykj.domestic.util.HttpClientUtil;
import com.cykj.domestic.util.ResultData;
import com.cykj.domestic.util.UserConstantInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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

    //修改用户个人信息
    @RequestMapping("/updateUserInfo")
    public String updateUserInfo(User user) {
        ResultData resultData = userService.updateUserInfo(user);
        return JSON.toJSONString(resultData);
    }

    //将头像地址插入到数据库
    @RequestMapping("/uploadAvatar")
    public String uploadAvatar(User user) {
        ResultData resultData = userService.uploadAvatar(user);
        return JSON.toJSONString(resultData);
    }

    //上传头像
    @RequestMapping(value = "/upload")
    public String upload(HttpServletRequest request, HttpServletResponse response, Database database, MultipartFile file) {
        try {
            //获取文件名
            String originalName = file.getOriginalFilename();
            //扩展名
            String prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
            Date date = new Date();
            //使用UUID+后缀名保存文件名，防止中文乱码问题
            String uuid = UUID.randomUUID() + "";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String dateStr = simpleDateFormat.format(date);
            String savePath = request.getSession().getServletContext().getRealPath("/upload/");
            String projectPath = savePath + "database" + File.separator + uuid + "." + prefix;
            String fileupload = "/upload/" + "database" + File.separator + uuid + "." + prefix;
            File files = new File(projectPath);
            //打印查看上传路径
            if (!files.getParentFile().exists()) {//判断目录是否存在
                files.getParentFile().mkdirs();
            }
            file.transferTo(files); // 将接收的文件保存到指定文件中
            ResultData resultData = new ResultData();
            resultData.setCode(0);
            resultData.setMsg(fileupload);
            return JSON.toJSONString(resultData);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }



    //微信登录
    @RequestMapping("/weChatLogin")
    public String weChatLogin(@RequestParam("code") String code,
                              @RequestParam("userHead") String userHead,
                              @RequestParam("userName") String userName,
                              @RequestParam("userGender") String userGender,
                              @RequestParam("userCity") String userCity,
                              @RequestParam("userProvince") String userProvince) {
        ResultData resultData = userService.weChatLogin(code, userHead, userName, userGender);
        return JSON.toJSONString(resultData);
    }
}
