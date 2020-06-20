package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Knowledge;
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
    public String queryKnowledeg(HttpServletRequest request, HttpServletResponse response, String title, String page, String limit) {
//        String title = request.getParameter("title");
        ResultData resultData = knowledgeService.queryKnowledeg(title, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }

    /*育儿知识增加*/
    @ResponseBody
    @RequestMapping("/addKnowledeg")
    public String addKnowledeg(HttpServletRequest request, HttpServletResponse response, Knowledge knowledge) {
        System.out.println(JSON.toJSONString(knowledge));
        ResultData resultData = knowledgeService.addKnowledeg(knowledge);
        return JSON.toJSONString(resultData);
    }

    /*育儿知识批量删除*/
    @ResponseBody
    @RequestMapping("/deleteKnowledeg")
    public String deleteKnowledeg(HttpServletRequest request, HttpServletResponse response, String idList) {
        ResultData resultData = knowledgeService.deleteKnowledeg(idList);
        return JSON.toJSONString(resultData);
    }
    /*上传育婴知识*/
    @RequestMapping("/updateknowledeg")
    public String updateknowledeg(HttpServletRequest request,HttpServletResponse response, Knowledge knowledge){
        ResultData resultData = knowledgeService.updateknowledeg(knowledge);
        return JSON.toJSONString(resultData);
    }
    @RequestMapping("/queryKnowledegStyle")
    public String queryKnowledegStyle(HttpServletRequest request,HttpServletResponse response, Knowledge knowledge){
        ResultData resultData=knowledgeService.queryKnowledegStyle(knowledge);
        return JSON.toJSONString(resultData);
    }

//     增加育婴知识-
    @RequestMapping("/addKnowledegStyle")
    public String addKnowledegStyle(HttpServletRequest request, HttpServletResponse response, Knowledge knowledge) {
        ResultData resultData = knowledgeService.addKnowledegStyle(knowledge);
        return JSON.toJSONString(resultData);
    }
    //     微信查询所有育婴知识-
    @RequestMapping("/wxqueryknowledge")
    public String wxqueryknowledge(HttpServletRequest request, HttpServletResponse response) {
        ResultData resultData = knowledgeService.wxqueryknowledge();
        return JSON.toJSONString(resultData);
    }

}
