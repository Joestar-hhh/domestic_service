package com.cykj.domestic.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.cykj.domestic.entity.Qualification;
import com.cykj.domestic.entity.SkillTrain;
import com.cykj.domestic.service.SkillTrainService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@RestController
@RequestMapping("/skillTrainController")
public class SkillTrainController {

    @Autowired
    private SkillTrainService skillTrainService;

    //技能培训列表
    @ResponseBody
    @RequestMapping(value = "/querySkillTrain")
    public String querySkillTrain(HttpServletRequest request, HttpServletResponse response, String page, String limit) {
        System.out.println("querySkillTrain--------------limit:" + limit + "--------page:" + page);
        ResultData resultData = skillTrainService.querySkillTrain(Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData, SerializerFeature.DisableCircularReferenceDetect);
    }

    @ResponseBody
    @RequestMapping(value = "/deleteSkillTrain")
    public String deleteSkillTrain(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        System.out.println("技能培训=" + id);
        ResultData resultData = skillTrainService.deleteSkillTrain(id);
        return JSON.toJSONString(resultData);
    }

    //    查找所有技能证书
    @ResponseBody
    @RequestMapping(value = "/queryqualification")
    public String queryqualification(HttpServletRequest request, HttpServletResponse response) {
        ResultData resultData = skillTrainService.queryqualification();
        return JSON.toJSONString(resultData);
    }

    //    修改技能培训
    @ResponseBody
    @RequestMapping(value = "/updateSkillTrain")
    public String updateSkillTrain(HttpServletRequest request, HttpServletResponse response, SkillTrain skillTrain) {
        System.out.println("updateSkillTrain=" + JSON.toJSONString(skillTrain));
        ResultData resultData = skillTrainService.updateSkillTrain(skillTrain);
        return JSON.toJSONString(resultData);
    }

    //添加技能培训项目
    @ResponseBody
    @RequestMapping(value = "/insertSkillTrain")
    public String insertSkillTrain(HttpServletRequest request, HttpServletResponse response, SkillTrain skillTrain) {
        System.out.println("insertSkillTrain=" + JSON.toJSONString(skillTrain));
        ResultData resultData = skillTrainService.insertSkillTrain(skillTrain);
        System.out.println(JSON.toJSONString(resultData));
        return JSON.toJSONString(resultData);
    }

    //添加技能证书
    @ResponseBody
    @RequestMapping(value = "/insertqualification")
    public String insertqualification(HttpServletRequest request, HttpServletResponse response, Qualification qualification) {
        System.out.println("qualification=" + JSON.toJSONString(qualification));
        ResultData resultData = skillTrainService.insertqualification(qualification);
        System.out.println(JSON.toJSONString(resultData));
        return JSON.toJSONString(resultData);
    }

    /*获取培训风采图片路径*/
    @RequestMapping(value = "/querySkillStyle")
    public String querySkillStyle(HttpServletRequest request, HttpServletResponse response, SkillTrain skillTrain) {
        System.out.println("qualification=" + JSON.toJSONString(skillTrain));
        ResultData resultData = skillTrainService.querySkillStyle(skillTrain);
        System.out.println(JSON.toJSONString(resultData));
        return JSON.toJSONString(resultData);
    }

    /*添加上传的培训风采图片*/
    @RequestMapping(value = "/insertSkillStyle")
    public String insertSkillStyle(HttpServletRequest request, HttpServletResponse response, SkillTrain skillTrain) {
        ResultData resultData = skillTrainService.insertSkillStyle(skillTrain);
        return JSON.toJSONString(resultData);
    }

    //上传
    @ResponseBody
    @RequestMapping(value = "/fileUpload")
    public String fileUpload(HttpServletRequest request, HttpServletResponse response, SkillTrain skillTrain, MultipartFile file) {
        try {
            //获取文件名
            String originalName = file.getOriginalFilename();
            //扩展名
            String prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
            Date date = new Date();
            //使用UUID+后缀名保存文件名，防止中文乱码问题
            String uuid = UUID.randomUUID() + "";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String dateStr = simpleDateFormat.format(date);
            String savePath = request.getSession().getServletContext().getRealPath("/upload/");
            String projectPath = savePath + "SkillStyle" + File.separator + uuid + "." + prefix;
            String fileupload = "/upload/" + "SkillStyle" + File.separator + uuid + "." + prefix;
            System.out.println("projectPath==" + projectPath);
            File files = new File(projectPath);
            //打印查看上传路径
            if (!files.getParentFile().exists()) {//判断目录是否存在
                System.out.println("files11111=" + files.getPath());
                files.getParentFile().mkdirs();
            }
            file.transferTo(files); // 将接收的文件保存到指定文件中
            System.out.println(projectPath);
            ResultData resultData = new ResultData();
            resultData.setCode(0);
            resultData.setMsg(fileupload);
            return JSON.toJSONString(resultData);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


}
