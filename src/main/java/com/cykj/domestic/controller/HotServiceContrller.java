package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.HotServiceService;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/hotServiceContrller")
public class HotServiceContrller {

    @Autowired
    private HotServiceService hotServiceService;

//查询所有服务列表数据
    @RequestMapping("/hotServiceQuery")
    public String hotServiceQuery(HttpServletRequest request, HttpServletResponse response, TbService tbService, String page, String limit) {
        ResultData resultData = hotServiceService.hotServiceQuery(tbService, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

}
