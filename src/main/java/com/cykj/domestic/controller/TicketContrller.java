package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.entity.Ticket;
import com.cykj.domestic.service.ServiceListService;
import com.cykj.domestic.service.TicketService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/ticketContrller")
public class TicketContrller {

    @Autowired
    private TicketService ticketService;

//查询所有服务列表数据
    @RequestMapping("/selectServiceList")
    public String selectServiceList(HttpServletRequest request, HttpServletResponse response, Ticket ticket, String page, String limit) {
        ResultData resultData = ticketService.selectList(ticket, Integer.parseInt(page), Integer.parseInt(limit));
        return JSON.toJSONString(resultData);
    }


    @RequestMapping("/addServiceList")
    public String addServiceList(HttpServletRequest request, HttpServletResponse response, Ticket ticket) {
        ResultData resultData=ticketService.addServicelist(ticket);
        System.out.println("发放优惠券传给controller的数据"+JSON.toJSONString(ticket));
        return JSON.toJSONString(resultData);
    }


    //修改服务列表数据
    @RequestMapping("/updateServiceList")
    public String updateServiceType(HttpServletRequest request, HttpServletResponse response, Ticket ticket) {
        ResultData resultData=ticketService.updateServiceList(ticket);

        return JSON.toJSONString(resultData);
    }


    //删除服务列表数据
    @RequestMapping("/deleteServiceList")
    public String deleteServiceType(HttpServletRequest request, HttpServletResponse response,int id) {
        ResultData resultData=ticketService.deleteServiceList(id);
        return JSON.toJSONString(resultData);
    }


//小程序首页显示优惠券
    @RequestMapping("/selectServiceListWx")
    public String selectServiceListWx(HttpServletRequest request, HttpServletResponse response, Ticket ticket,int userid) {
        System.out.println("-----------------------首页优惠券查询ticket:"+ticket.toString());
        ResultData resultData = ticketService.selectListWx(ticket,userid);
        return JSON.toJSONString(resultData);
    }


//我的优惠券
    @RequestMapping("/myTicketquery")
    public String myTicketquery(HttpServletRequest request, HttpServletResponse response, Ticket ticket,int userid) {
        System.out.println("ticket:"+ticket.toString());
        ResultData resultData = ticketService.myTicketquery(ticket,userid);
        return JSON.toJSONString(resultData);
    }


//    //通过状态查询我的优惠券
//    //我的优惠券
//    @RequestMapping("/selectServiceListWx3")
//    public String selectServiceListWx3(HttpServletRequest request, HttpServletResponse response, Ticket ticket,int userid) {
//        ResultData resultData = ticketService.selectListWx3(ticket,userid);
//        return JSON.toJSONString(resultData);
//    }


    //领取优惠券
    @RequestMapping("/updateTicket")
    public String updateTicket(HttpServletRequest request, HttpServletResponse response, Ticket ticket,int userid) {
        ResultData resultData=ticketService.updateTicket(ticket,userid);
        return JSON.toJSONString(resultData);
    }
}
