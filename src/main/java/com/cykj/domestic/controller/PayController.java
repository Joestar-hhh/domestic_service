package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.util.AgeUtil;
import com.cykj.domestic.util.AlipayConfig;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RequestMapping("/payController")
@RestController
public class PayController {

    @RequestMapping("/payController")
    public void payController(HttpServletRequest request, HttpServletResponse response, String orderObj) throws IOException {
//         String oid, String onum,String money,String cname
        System.out.println("----------------6666");
//        System.out.println("orderObj:"+onum);
//        OrderInfo orderInfo = new OrderInfo();
//        orderInfo.setId(Integer.parseInt(oid));
//        orderInfo.setOrderNumber(onum);
//        orderInfo.setMoney(money);
//        orderInfo.setComName(cname);
        OrderInfo orderInfo = JSON.parseObject(orderObj,OrderInfo.class);

        System.out.println("订单号："+orderInfo.getOrderNumber());
        System.out.println("orderInfo:"+orderInfo.toString());
        //获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.APP_ID, AlipayConfig.APP_PRIVATE_KEY, "json", AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.sign_type);

        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = orderInfo.getOrderNumber();
        //付款金额，必填
        String total_amount = orderInfo.getMoney();
        //订单名称，必填
        String subject = orderInfo.getComName();
        //商品描述，可空
        String body = "家政服务";

//        alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
//                + "\"total_amount\":\"" + total_amount + "\","
//                + "\"subject\":\"" + subject + "\","
//                + "\"body\":\"" + body + "\","
//                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");


        //若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
        alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
                + "\"total_amount\":\"" + total_amount + "\","
                + "\"subject\":\"" + subject + "\","
                + "\"body\":\"" + body + "\","
                + "\"timeout_express\":\"5m\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
        //请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节

        //请求
        String form = "";
        try {
            form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        response.setContentType("text/html;charset=" + AlipayConfig.CHARSET);
        response.getWriter().write(form);//直接将完整的表单html输出到页面
        response.getWriter().flush();
        response.getWriter().close();
    }



    @RequestMapping("/paytest")
    public void paytest(HttpServletRequest request, HttpServletResponse response, String oid, String onum,String money,String cname) throws IOException {
        System.out.println("----------------6666");


        //获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.APP_ID, AlipayConfig.APP_PRIVATE_KEY, "json", AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.sign_type);

        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = onum;
        //付款金额，必填
        String total_amount = money;
        //订单名称，必填
        String subject = cname;
        //商品描述，可空
        String body = "家政服务";

//        alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
//                + "\"total_amount\":\"" + total_amount + "\","
//                + "\"subject\":\"" + subject + "\","
//                + "\"body\":\"" + body + "\","
//                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        //若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
        alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
                + "\"total_amount\":\"" + total_amount + "\","
                + "\"subject\":\"" + subject + "\","
                + "\"body\":\"" + body + "\","
                + "\"timeout_express\":\"5m\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
        //请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节

        //请求
        String form = "";
        try {
            form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        response.setContentType("text/html;charset=" + AlipayConfig.CHARSET);
        response.getWriter().write(form);//直接将完整的表单html输出到页面
        response.getWriter().flush();
        response.getWriter().close();
    }

}