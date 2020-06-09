package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Role;
import com.cykj.domestic.service.KnowledgeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/knowledgeController")
public class KnowledgeController {

    @Autowired
    private KnowledgeService knowledgeService;

/*
*   育儿知识
*/
    @ResponseBody
    @RequestMapping(value = "queryKnowledeg")
    public String queryKnowledeg(HttpServletRequest request, HttpServletResponse response, String page, String limit){
       String title=request.getParameter("title");
        ResultData resultData=knowledgeService.queryKnowledeg(title,Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

   /*
   * 育儿知识增加
   * */

   /*
   * 育儿知识删除
   * */
   @RequestMapping("/deleteKnowledeg")
   public String deleteKnowledeg(HttpServletRequest request, HttpServletResponse response, String idList){
       ResultData resultData =knowledgeService.deleteKnowledeg(idList);
       return JSON.toJSONString(resultData);
   }


}
