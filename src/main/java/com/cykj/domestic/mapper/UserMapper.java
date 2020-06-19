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

    //用户登陆
    User userLogin(User user);

    //公司最大账号
    String  MaxAccount();

    /*家政公司根据手机号码查询*/
    User queryUserPhone(User user);

    //    用户注册
    int insertUser(User user);

    //用户忘记修改密码
    int phone_update_pwd(User user
    );

    // 修改用户信息
    int updateUserInfo(User user);

    //用户上传头像
    int uploadAvatar(User user);


    User queryOpenIdUser(String openId);

    int insertUserInfo(User user);
    int uploadLoginTime(User user);
}
