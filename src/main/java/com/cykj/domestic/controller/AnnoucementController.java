package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Annoucement;
import com.cykj.domestic.entity.Role;
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
/*
    添加公告
 */
    @RequestMapping("/insertAnnoucement")
    public String insertAnnoucement(HttpServletRequest request, HttpServletResponse response, Annoucement annoucement){
        ResultData resultData= annoucementService.insertAnnoucement(annoucement);
        return JSON.toJSONString(resultData);
    }
    /*
    修改公告
     */
@RequestMapping("/updateAnnouncement")
public String updateAnnoucement(HttpServletRequest request, HttpServletResponse response, Annoucement annoucement){
    System.out.println("updateRole--------------role:"+annoucement.toString());
    ResultData resultData = annoucementService.updateAnnoucement(annoucement);
    return JSON.toJSONString(resultData);
}
    /*
    删除公告
     */
    @RequestMapping("/deleteAnnoucement")
    public String deleteAnnouncement(HttpServletRequest request, HttpServletResponse response, String idList){
        System.out.println("updateRole--------------idList:"+idList);
        ResultData resultData = annoucementService.deleteAnnoucement(idList);
        return JSON.toJSONString(resultData);
    }

}
