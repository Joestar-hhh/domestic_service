package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Annoucement;
import com.cykj.domestic.service.AnnoucementService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/annoucementController")
public class AnnoucementController {

   @Autowired
    private AnnoucementService annoucementService;

    /*
        家政管理端公告管理
     */
    @RequestMapping("/queryAnnoucement")
    public String queryAnnoucement(HttpServletRequest request, HttpServletResponse response,
                                    Annoucement annoucement,String page,String limit){
        ResultData resultData = annoucementService.queryAnnoucementList(annoucement,Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);

    }

}
