package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Map;
import com.cykj.domestic.service.MapSevice;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.PropertyValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;

@RestController
@RequestMapping("/mapController")
public class MapController {

    @Autowired
    private MapSevice mapSevice;

    @ResponseBody
    @RequestMapping(value = "/querymap")
    public String querymap() {
        HashMap<String, ArrayList<Map>> hashMap = mapSevice.querymap();
        System.out.println("map:"+JSON.toJSONString(hashMap));
        return JSON.toJSONString(hashMap);
    }

    //    查找所有父级地区
    @ResponseBody
    @RequestMapping(value = "/queryfirstLevelRegion")
    public String queryfirstLevelRegion(HttpServletResponse response, HttpServletRequest request) {
      ResultData resultData=mapSevice.queryfirstLevelRegion();
        return JSON.toJSONString(resultData);
    }
    //    查找次一级地区

    @ResponseBody
    @RequestMapping(value = "/querySecondaryZone")
    public String querySecondaryZone(HttpServletResponse response, HttpServletRequest request) {
        String id= request.getParameter("id");
        System.out.println(id);
        ResultData resultData=mapSevice.querySecondaryZone(id);
        return JSON.toJSONString(resultData);
    }

}
