package com.cykj.domestic.util;

import java.io.FileWriter;
import java.io.IOException;

public class AlipayConfig {


        // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号,开发时使用沙箱提供的APPID，生产环境改成自己的APPID
        public static String APP_ID = "2016102500755547";

        // 商户私钥，您的PKCS8格式RSA2私钥
        public static String APP_PRIVATE_KEY = "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC/dHEfj0JCIl02c288NUl3r0aXhiNjVym81l4EnVWmWWzQhpNxFjSWWY/8pBdKVbfBfpdmu7IYZ8tAjlt7FSyEdLiv3K9en2++3hHHgEn9AN1caDW8GTaxjxh0zlNCE6M9DKjjIdSGETTUxIVH0phGx6iLR6u7KJ1puTgXy+tDAKnaYgYxsBZZtYgnUY3Qm7pmLIbw7jNLW7uGVw3hXDAH10M42G7swP3XISg6y5Sj0v/ul6ukc1n+eLBzAyJl3Lqfn2OcpqB8EpAVRO1Eh8Gcd+oDDHVhVlRIBg785D6vTssFbL5YQYuMt10cRARDpSUo+r9asFWGo8SdIFUZOoOhAgMBAAECggEAC6W22BesDT/v8ccWBlCrlodoQQGdF4cO9/kGoTs9IbChCRKW17NlIZxzQQhujkwmsLPV3B8hF5EA8X13nUZNfgVn0vMXDCeg8biq1js8xRKPZPbGBhp2lFjDQR/oOsXdEXK6t46wUjOrxiHqhdMPBodQ/qAul2VCJlNpUTFLr7i4kAvsCdbJ//2oSfz/PSQfgOM0le4BxmzHwrKxzFad1NFXpwxAOCvyeyjGDSLyfJWXTMqpnC7KH+CCz5T4AC3GXr4h+aJKPBqKQHMjqAO3jAjFFgUhRzqOzy66q0tnPBPnfTew4/rhGOGJi/Xeziekg/BW+WFSqLKe+/Lf2Tc5zQKBgQDyhcXJW7hp9PV20xdKOWWyFMSc38+KHthEDJneS03ZmnY8OErDjEbPpdVgBjnokbMG/+g2kkWsmkzB6Qkn2VBFXHBLHkAkhUT80325qBF4dGG9jmjudEci8YtPmo5opBkhqp/X4eG3FaAatVnnkdXcvIYKW8e7y3s0juhvhzK5hwKBgQDKGCioFGOuyI10Cl6HADu0p0WIRLSbZ86Dxdx85Cvc2jOaA9WQ5VB3k4TZnJZRwl9rAbGM5wEpNQBrGQwtMz+xhWo//0AIGzlLaHiKBrQVKd02fFR3jp5wmZtweFqulrnlIAmy7Ih4FZTS986EdETew1brdnIye3IJscRVi2mDlwKBgQCBXCNkxTy3n8ayi+QXXkhFVdiNyL+977fxjDsinE45LK+2bVxLs+4tYkpPPuLyj4zLxgKJ4Tmy2Fbq869DhyHO7YCkQM177W4f4XtlZSV0d7eO0YBc+L7c/7QMUOd3H1icYZODJmQsMSfGN0duQpateA2TRuNh4yajoTqQCrBezwKBgQCacHnpcKN495R54E66tmfqN4ZAi9jFhj/gnb1QyAHpJesXQOTddRDYQKjer/aEBplqqgGoXwSZHAL01VBj3m1HWWCIBaVGTJ+tS+oJ+PN31OVTdRILx7a27/xEqAUMtOzc923SCUaFFmEEFBIDUOMspXTwPjUo9QOB+xLCGOcKgwKBgQC/trmz5r0g+epYRdkX2AEZSej0NyyWun6MyGaUbBRy8uCWo4fLqj7F79Voy3TcjUJysvz9QLur3sXkC9Jk3Gk27ZHsEQptZkd4yc+BTXhLsm9dFQgM1QlI7UENZljKwdO/r4RdNVAomF37rGrvLeOexXAjsRWt94HqGkjldAVyow==\n";

        // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
        public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv3RxH49CQiJdNnNvPDVJd69Gl4YjY1cpvNZeBJ1Vplls0IaTcRY0llmP/KQXSlW3wX6XZruyGGfLQI5bexUshHS4r9yvXp9vvt4Rx4BJ/QDdXGg1vBk2sY8YdM5TQhOjPQyo4yHUhhE01MSFR9KYRseoi0eruyidabk4F8vrQwCp2mIGMbAWWbWIJ1GN0Ju6ZiyG8O4zS1u7hlcN4VwwB9dDONhu7MD91yEoOsuUo9L/7perpHNZ/niwcwMiZdy6n59jnKagfBKQFUTtRIfBnHfqAwx1YVZUSAYO/OQ+r07LBWy+WEGLjLddHEQEQ6UlKPq/WrBVhqPEnSBVGTqDoQIDAQAB";

        // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
        public static String notify_url = "http://localhost:8080/pages/user/notify_url.jsp";

        // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问(其实就是支付成功后返回的页面)
        public static String return_url = "http://localhost:8080/pages/user/webview_2.jsp";

        // 签名方式
        public static String sign_type = "RSA2";

        // 字符编码格式
        public static String CHARSET = "utf-8";

        // 支付宝网关，这是沙箱的网关
        public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

        // 支付宝网关
        public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

        /**
         * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
         * @param sWord 要写入日志里的文本内容
         */
        public static void logResult(String sWord) {
            FileWriter writer = null;
            try {
                writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
                writer.write(sWord);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (writer != null) {
                    try {
                        writer.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

}
