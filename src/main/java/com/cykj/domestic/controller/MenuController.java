package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.MenuData;
import com.cykj.domestic.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/menuController")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("/queryMenu")
    public String queryMenu(){
        List<MenuData> menuDataList = menuService.queryList();
        return JSON.toJSONString(menuDataList);
    }
}
