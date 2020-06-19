package com.cykj.domestic.util;

public interface UserConstantInterface {

    // 请求的网址
    public static final String WX_LOGIN_URL = "https://api.weixin.qq.com/sns/jscode2session";
    // 你的appid
    public static final String WX_LOGIN_APPID = "wx309481d22421aaee";
    // 你的密匙
    public static final String WX_LOGIN_SECRET = "af0dc54884e484f4c6e3989426686c86";
    // 固定参数
    public static final String WX_LOGIN_GRANT_TYPE = "authorization_code";
}
