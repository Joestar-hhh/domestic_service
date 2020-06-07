package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Annoucement;
import com.cykj.domestic.mapper.AnnoucementMapper;
import com.cykj.domestic.service.AnnoucementService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AnnoucementServiceImpl implements AnnoucementService {

    @Autowired
    private AnnoucementMapper annoucementMapper;

    @Override
    public ResultData queryAnnoucementList(Annoucement annoucement, int page, int limit) {
        List<Annoucement> list=annoucementMapper.queryAnnoucement(annoucement,(page-1)*limit,limit);
        int count=annoucementMapper.queryAnnoucementCount(annoucement);

        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }
    /*
    添加公告
     */

    @Override
    public ResultData insertAnnoucement(Annoucement annoucement) {
       int res=  annoucementMapper.insertAnnoucement(annoucement);
       ResultData resultData=new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;

    }
    /*
    修改公告
     */

    @Override
    public ResultData updateAnnoucement(Annoucement annoucement) {
        int res = annoucementMapper.updateAnnouncement(annoucement);
        ResultData resultData = new ResultData();
        if(res==1){
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }
    /*
        删除公告
     */

    @Override
    public ResultData deleteAnnoucement(String idList) {
        List<String> list = JSON.parseArray(idList,String.class);
        int res = annoucementMapper.deleteAnnouncement(list);
        ResultData resultData = new ResultData();
        if(res>=1){
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }
}
