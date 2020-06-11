package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.BackAdmin;
import com.cykj.domestic.service.BackAdminService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/backAdminController")
public class BackAdminController {

    @Autowired
    private BackAdminService backAdminService;

    //管理平台端登入
    @RequestMapping("/backadminLogin")
    public String backadminLogin(HttpServletResponse response, HttpServletRequest request, BackAdmin backAdmin) {
//        request.
        ResultData resultData=backAdminService.backadminLogin(backAdmin);
        return JSON.toJSONString(resultData);
    }





}
