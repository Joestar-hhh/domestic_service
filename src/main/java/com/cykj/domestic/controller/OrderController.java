package com.cykj.domestic.controller;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.entity.OrderState;
import com.cykj.domestic.entity.Role;
import com.cykj.domestic.service.OrderService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/*
 * 订单controller
 */
@RestController
@RequestMapping("/orderController")
public class OrderController {


    @Autowired
    private OrderService orderService;

    /*
     * 查询订单信息
     */
    @RequestMapping("/queryOrder")
    public Object queryOrder(String companyName, String page, String limit) {
        ResultData resultData = orderService.queryOrderInfo(companyName, Integer.parseInt(page), Integer.parseInt(limit));
        return resultData;
    }

    /*
     * 删除订单信息
     */
    @RequestMapping("/deleteOrder")
    public String deleteOrder(String idList) {
        ResultData resultData = orderService.deleteOrder(idList);
        return JSON.toJSONString(resultData);
    }

    // 统计前先显示公司列表下拉框
    @RequestMapping("/queryCompanyList")
    public String queryCompanyList(Company company) {
        ResultData resultData = orderService.queryCompanyList(company);
        return JSON.toJSONString(resultData);
    }

    //统计订单数
    @RequestMapping("/orderStatistics")
    public String orderStatistics(HttpServletRequest request, HttpServletResponse response) {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String companyName = request.getParameter("companyName");
        List<OrderInfo> list = orderService.orderStatistics(startDate, endDate, companyName);
        return JSON.toJSONString(list);
    }

//    发布需求统计
    @RequestMapping("/requireStatistics")
        public String requireStatistics(HttpServletRequest request, HttpServletResponse response) {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        List<OrderInfo> list = orderService.requireStatistics(startDate, endDate);
        return JSON.toJSONString(list);

        }

    /*
     * 售后追踪
     */
    @RequestMapping("/afterSale")
    public Object afterSale(OrderInfo orderInfo, String page, String limit,String orderNumber) {
        ResultData resultData = orderService.afterSaleList(orderInfo, Integer.parseInt(page), Integer.parseInt(limit),orderNumber);
        return resultData;
    }

//    获取下拉框订单状态
    @RequestMapping("/orderStatelist")
    public String orderStatelist(OrderState orderState){
        ResultData resultData=orderService.orderStatelist(orderState);
        return JSON.toJSONString(resultData);
    }

//    家政公司订单管理
    @RequestMapping("/companyOrderList")
    public Object companyOrderList(HttpServletRequest request,OrderInfo orderInfo, String page, String limit,String stateComName) {
        Company company = (Company) request.getSession().getAttribute("company");
        ResultData resultData = orderService.companyOrderList(orderInfo, Integer.parseInt(page), Integer.parseInt(limit),stateComName,String.valueOf(company.getId()));
        return resultData;
    }

//    接单
    @RequestMapping("/orders")
    public String orders(OrderInfo orderInfo) {
        ResultData resultData = orderService.orders(orderInfo);
        return JSON.toJSONString(resultData);
    }

    //家政公司订单统计
    @RequestMapping("/companyOrderStatistics")
    public String companyOrderList(HttpServletRequest request, HttpServletResponse response) {
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        List<OrderInfo> list = orderService.companyOrderStatistics(startDate, endDate);
        return JSON.toJSONString(list);

    }
//    小程序订单查询
    @RequestMapping("/weChatOrderList")
    public String weChatOrderList(HttpServletRequest request){
        String  userId=request.getParameter("userId");
        ResultData resultData=orderService.weChatOrderList(Integer.valueOf(userId));
        return JSON.toJSONString(resultData);
    }

}
