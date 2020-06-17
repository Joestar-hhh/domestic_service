package com.cykj.domestic.util;

import java.io.FileWriter;
import java.io.IOException;

public class AlipayConfig {


        // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号,开发时使用沙箱提供的APPID，生产环境改成自己的APPID
        public static String APP_ID = "2016102900775323";

        // 商户私钥，您的PKCS8格式RSA2私钥
        public static String APP_PRIVATE_KEY = "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDIKHLr4zEfxIvi71qlecVpqs68jhI8ZYWdcvlJIe0v4bQnNqqegtLtl4KCh5JVOtBuzyF8EqULm6zh87mgtFPMRQbQpPKJrUYNlj/w6q+V7Co8cTdSI/giDAae+QD7Jv22tJEwFjFrj/U3HUndBRF8rLIRs0WPUlmGQ6na7WyYCPhx81m9OKgLIFoSRXBobbGJzB6vu6eV3oGwVF8KKVWtJp6wMzblyYzmu9yVy+OPTxK+kxlSaIlPJWwGDoR7+ZUyRF4O2MrJSLog1NajbyinXBysSa11GdE5eX7sCiXpDJTo1lmiwaw1P0RvdMdu5MoYiu570wf1Ft3oqtAm6MSFAgMBAAECggEBAJ3p06kpKGOQ1HBpOJHe/ZH9UXfPerGtwvnScLxzCMdDAbgCWCAQxMrwQuYqgZe+fB1AS4Gw0AfVfVMSz7vrKUW6m8LWsAdQ7jjf9nhjH75fgX8IL4YdnLF33W1ktJJxU6/my7kteTYMcIFYGSNH0WEUerSeRF3rsXfNQF/Z+1gCLhQ5v68g4NdlHc0g8E0bItCWLKyg6CpZWKnEQhPbl38Q8nnD251AZXI1bZc0tJ5f8T5q478fYVpXq/tS80Wuw4879uSOMqNlRHegmiC+DlK5Nlt5hoT401BmNYtKbSloOuzxysaMhb8+TLTbntBRHmA67J2Ltw5YjgpIaJky5q0CgYEA7vcxVCnnxq+/TNooXl9qADXUp7q8dNVigaCmIh92ZuYOW6Y80s5kQSaCCmPhlUzFCrp6+XT8OIR4QTnG/BZEpHZBXk88W9ucvAcP/AeHHF+wmNiUWaRGdhIkhJZ3Y5EuvwaNZxThrAEH90/X6nZDkMUN+W8Eb56me9dFGuau1fsCgYEA1m0Rm3UuLDto3lmp9/ULUWAzd3Axnzc+1V8qwW3gc7VSpfWtBxaRnD5yUJrg5PfRgNZmNqPmXAW2ySLhbo8ZLjK88cEAfEnlzZWvtrOSdPQhmtOidqeUqHXEBdus/PnK3vGV4Ae7SpisyGMNCxi5O9CY/dI33mQx/JCexpY8R38CgYBN7KfWVS/yl37fVciSNbUASo2FAJzR0H+l27gxKmdW2LBX7Jaq+4ivwhnnv3hhUj5y6CqPzDkvSOtaAbhEnhJWOwXH9jitj6jFm9v3iJDjjMSuovmFXc9oUzQ7VEGsYzyGKGHV+nY4u8FYQV4cY+JWhBuxeiVNLMQHYER1qEHdHwKBgQCpwk3XQq1cbWh36IrM+R6NvVjhrVxLzeQb7y0dWE0DrkERjPAAlZiQF0xPjl6QR7aAhr0Dcz0UC54LnWbWLcpkrdyylPc6bxLVcTVcssw3dXQJbJXJ1KC3wgyACsvouCYp3R+n7tcTls3sE6cm6trzhREqmjyK/84nQ6PAWv68JwKBgQCui+fv3/aJAUCx0Ktl3QhAabNQmIj/XSVQQRhJdyc/szEFPXLT8qNOGrpuDQ9BbiRomxd7trKYaKHDcnVfni6/K/HHzhOWlrUZfTAluGusnyIP8C0WPZPs2K8Yat/CtaU+B/xLE2xdYUsCaCVMkwUeJyrhwQk+vZib8SEDEHdjeQ==";

        // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
        public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiojpehzKRiXWqSI//le3NEgs/ZmVHpfNoQBzW2EUgT8MaqQhQOp7Va6QEQb7Zx9T2bglXy3vIRmlcFvDP09nSjAVi8JJjT9dj6iwV9UMGUHp5hSuBFOwtirT/anTRugiv6/aE6CtVm6pYf79ZoS5GbYRoVJPlBO4MIqgvSzYGHU5eSutOhkhEVpPQ9j7a6iUqk/8/pTwAEvM0JXIhkUXLBshEqnk7OUna+ZJI4du2Gn/i+TYd+6xutrZyWR3VeT1DoaM/ibhxedChrX2Pbpxs2qgbJThOg/WydRDzJW7drKC0GF843yVDULoV93EgfmWsMflVzfb++1FmBmrBexDSwIDAQAB";

        // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
        public static String notify_url = "http://localhost:8080/pages/user/notify_url.jsp";

        // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问(其实就是支付成功后返回的页面)
        public static String return_url = "http://localhost:8080/pages/user/user_login.jsp";

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
