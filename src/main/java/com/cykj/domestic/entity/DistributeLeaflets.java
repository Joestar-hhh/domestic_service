package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class DistributeLeaflets {
    private  int id;
    private String orderNumber;//订单号
    private String pulishTime;//发布时间
    private String startTime;
    private String endTime;
    private String title;//标题
    private String description;//描述
    private String name;//用户名字
    private String userName;
    private int userId;

}
