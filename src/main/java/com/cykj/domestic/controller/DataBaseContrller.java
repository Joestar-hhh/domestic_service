package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.Database;
import com.cykj.domestic.entity.SkillTrain;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.service.DataBaseService;
import com.cykj.domestic.service.ServiceListService;
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
@RequestMapping("/dataBaseContrller")
public class DataBaseContrller {

    @Autowired
    private DataBaseService dataBaseService;

//查询公司资料
    @RequestMapping("/selectServiceList")
    public String selectServiceList(HttpServletRequest request, HttpServletResponse response, Database database, String page, String limit) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        ResultData resultData = dataBaseService.selectList(database, Integer.parseInt(page), Integer.parseInt(limit),company1.getId());
        return JSON.toJSONString(resultData);
    }

//添加公司资料
    @RequestMapping("/addServiceList")
    public String addServiceList(HttpServletRequest request, HttpServletResponse response, Database database) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        System.out.println("++++++++++++++++++++++++++++++"+JSON.toJSONString(database));
        ResultData resultData=dataBaseService.addServicelist(database,company1.getId());
    return JSON.toJSONString(resultData);
    }


    //查询详情
    @RequestMapping("/serviceListView")
    public String serviceListView(HttpServletRequest request, HttpServletResponse response,Database database) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        System.out.println("___++++++=========-"+JSON.toJSONString(database));
        ResultData resultData = dataBaseService.serviceListView(database,company1.getId());
        return JSON.toJSONString(resultData);
    }



    //上传公司凭证
    @RequestMapping(value = "/uploadvoucher")
    public String Uploadvoucher(HttpServletRequest request, HttpServletResponse response, Database database, MultipartFile file) {
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
            String projectPath = savePath + "database" + File.separator + uuid + "." + prefix;
            String fileupload = "/upload/" + "database" + File.separator + uuid + "." + prefix;
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



    //查询员工资料
    @RequestMapping("/selectStaffList")
    public String selectStaffList(HttpServletRequest request, HttpServletResponse response, Database database, String page, String limit) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        ResultData resultData = dataBaseService.selectStaff(database, Integer.parseInt(page), Integer.parseInt(limit),company1.getId());
        return JSON.toJSONString(resultData);
    }

    //添加员工资料
    @RequestMapping("/addStaffList")
    public String addStaffList(HttpServletRequest request, HttpServletResponse response, Database database) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        System.out.println("++++++++++++++++++++++++++++++"+JSON.toJSONString(database));
        ResultData resultData=dataBaseService.addStafflist(database,company1.getId());
        return JSON.toJSONString(resultData);
    }


    //查询员工详情
    @RequestMapping("/staffListView")
    public String staffListView(HttpServletRequest request, HttpServletResponse response,Database database) {
        Company company1 = (Company)request.getSession().getAttribute("company");
        System.out.println("___++++++=========-"+JSON.toJSONString(database));
        ResultData resultData = dataBaseService.StaffListView(database,company1.getId());
        return JSON.toJSONString(resultData);
    }



    //上传公司凭
    @RequestMapping(value = "/uploadstaff")
    public String uploadstaff(HttpServletRequest request, HttpServletResponse response, Database database, MultipartFile file) {
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
            String projectPath = savePath + "straff" + File.separator + uuid + "." + prefix;
            String fileupload = "/upload/" + "straff" + File.separator + uuid + "." + prefix;
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
