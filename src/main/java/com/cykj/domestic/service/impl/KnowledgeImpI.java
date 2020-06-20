package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Knowledge;
import com.cykj.domestic.mapper.KnowledgeMapper;
import com.cykj.domestic.service.KnowledgeService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class KnowledgeImpI implements KnowledgeService {
    @Autowired
    private KnowledgeMapper knowledgeMapper;

    //查询所有育儿知识
    @Override
    public ResultData queryKnowledeg(String title, int page, int limit) {
        List<Knowledge> list = knowledgeMapper.queryKnowledeg(title, (page - 1) * limit, limit);
        int count = knowledgeMapper.KnowledegCount(title);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    //批量删除育婴知识
    @Override
    public ResultData deleteKnowledeg(String idList) {
        List<String> list = JSON.parseArray(idList, String.class);
        int res = knowledgeMapper.deleteKnowledeg(list);
        ResultData resultData = new ResultData();
        if (res >= 1) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }

    //添加育儿知识
    @Override
    public ResultData addKnowledeg(Knowledge knowledge) {
        int res = knowledgeMapper.addKnowledeg(knowledge);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("添加成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加失败");
        }
        return resultData;
    }

    @Override
    public ResultData updateknowledeg(Knowledge knowledge) {
        int res = knowledgeMapper.updateknowledeg(knowledge);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("上传成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("上传失败");
        }
        return resultData;
    }

    //    获取育婴知识路径-
    @Override
    public ResultData queryKnowledegStyle(Knowledge knowledge) {
        List<Knowledge> list = knowledgeMapper.queryKnowledegStyle(knowledge);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

    //    增加育婴知识-
    @Override
    public ResultData addKnowledegStyle(Knowledge knowledge) {
        int res = knowledgeMapper.addKnowledegStyle(knowledge);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("上传成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("上传失败");
        }
        return resultData;
    }

    //微信查询育婴知识
    @Override
    public ResultData wxqueryknowledge() {
        List<Knowledge> list = knowledgeMapper.wxqueryknowledge();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }

}
