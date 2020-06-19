package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.ServiceType;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.entity.Ticket;
import com.cykj.domestic.mapper.ServiceListMapper;
import com.cykj.domestic.mapper.TicketMapper;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.service.TicketService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class TicketImpl implements TicketService {

    @Autowired
    public TicketMapper ticketMapper;


    //查询服务列表所有数据
    @Override
    public ResultData selectList(Ticket ticket, int page, int pageSize) {
        int start = (page - 1) * pageSize;//计算出起始查询位置
        List<Ticket> list = ticketMapper.selectList(ticket, start, pageSize);
        int count = ticketMapper.selectListCount(ticket);

        ResultData resultData = new ResultData();
        if (list.size() > 0) {
            resultData.setCode(0);
            resultData.setMsg("");
            resultData.setCount(count);
            resultData.setData(list);
            System.out.println(ticket);
        } else {
            resultData.setCode(1);
            resultData.setMsg("查询失败");
        }
        return resultData;
    }



    //修改服务列表数据
    @Override
    public ResultData updateServiceList(Ticket ticket) {
        int res = ticketMapper.updateServiceList(ticket);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("修改成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("修改失败");
        }
        return resultData;
    }
    @Override
    public ResultData addServicelist(Ticket ticket) {
        int res = ticketMapper.addServiceList(ticket);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("添加券成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("添加券失败");
        }
        return resultData;
    }

    //删除服务列表数据
    @Override
    public ResultData deleteServiceList(int id) {
        int res = ticketMapper.deleteServiceList(id);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }
}
