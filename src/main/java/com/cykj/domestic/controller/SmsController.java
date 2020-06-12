package com.cykj.domestic.controller;


import com.cykj.domestic.service.SmsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/smsController")
public class SmsController {


    @Autowired
    private SmsService smsService;


    @RequestMapping("/smsSend")
    private String smsSend(HttpServletRequest request, HttpServletResponse response,String phone){
        System.out.println("手机号码="+phone);
//        smsService.Sms("15160603831","159789");
        return null;
    }




}
