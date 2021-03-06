package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.CompanyAccount;
import com.cykj.domestic.entity.OrderInfo;
import com.cykj.domestic.mapper.UserOrderMapper;
import com.cykj.domestic.service.UserOrderService;
import com.cykj.domestic.util.AgeUtil;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
public class UserOrderImpI implements UserOrderService {

    @Autowired
    private UserOrderMapper userOrderMapper;

    //添加用户发布需求和下订单
    @Override
    public ResultData insertUserOrder(OrderInfo orderInfo) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String newDate = sdf.format(new Date());
        String result = "";
        Random random = new Random();
        for (int i = 0; i < 3; i++) {
            result += random.nextInt(10);
        }
        System.out.println("订单号=" + "CY" + newDate + result);
        orderInfo.setOrderNumber("CY" + newDate + result);
        orderInfo.setCompanyOrderStateId(1);
        orderInfo.setUserOrderStateId(5);
        int res = userOrderMapper.insertUserOrder(orderInfo);
        ResultData resultData = new ResultData();
        if (res > 0) {
            resultData.setCode(0);
            resultData.setMsg("发布成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("发布失败");
        }
        return resultData;

    }

    //需 求大厅
    @Override
    public ResultData queryUserDemend(OrderInfo orderInfo, int page, int limit) {
        List<OrderInfo> list = userOrderMapper.queryUserDemend(orderInfo, (page - 1) * limit, limit);
        int count = userOrderMapper.queryUserDemendCount(orderInfo);
        ResultData resultData = new ResultData();
        resultData.setCount(count);
        resultData.setData(list);
        return resultData;
    }

    //    公司接单
    @Override
    public ResultData updateUserDemend(OrderInfo orderInfo) {
        orderInfo.setCompanyOrderStateId(2);
        orderInfo.setUserOrderStateId(6);
        System.out.println(JSON.toJSONString(orderInfo));
        int res = userOrderMapper.updateUserDemend(orderInfo);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("接单成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("接单失败");
        }
        return resultData;
    }

    //微信小程序用户查询自己发布的需求
    @Override
    public ResultData WXUserQueryOrder(int id) {
        List<OrderInfo> list = userOrderMapper.WXUserQueryOrder(id);
        ResultData resultData= new ResultData();
        resultData.setData(list);
        return resultData;
    }

    //    微信小程序删除用户发布的需求/
    @Override
    public ResultData WXdeleteOrderrequirement(OrderInfo orderInfo) {
        int res=userOrderMapper.WXdeleteOrderrequirement(orderInfo);
        ResultData resultData = new ResultData();
        if (res == 1) {
            resultData.setCode(0);
            resultData.setMsg("删除成功");
        }
        else {
            resultData.setCode(1);
            resultData.setMsg("删除失败");
        }
        return resultData;
    }

    @Override
    public OrderInfo insertUserOrderInfo(OrderInfo orderInfo) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String newDate = sdf.format(new Date());
        orderInfo.setPulishTime(newDate);
        orderInfo.setCompanyOrderStateId(1);
        orderInfo.setOrderNumber(AgeUtil.getOrderNum());
        int res = userOrderMapper.insertUserOrderInfo(orderInfo);

        //公司账户明细
        CompanyAccount companyAccount = new CompanyAccount();
        companyAccount.setOrigin("服务收入");
        companyAccount.setAmountMoney(orderInfo.getMoney());
        companyAccount.setOptionType("支付宝支付");
        companyAccount.setCompanyId(orderInfo.getCompanyId());
        userOrderMapper.insertTradeInfo(companyAccount);
        return orderInfo;
    }

    @Override
    public int updateOrderState(String orderNum) {
        String updateOrderState = "2";
        String userOrderState = "7";
        int res = userOrderMapper.updateOrderState(updateOrderState,userOrderState,orderNum);
        return res;
    }


}
