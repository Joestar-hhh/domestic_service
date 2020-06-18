package com.cykj.domestic.entity;

import lombok.Data;

import java.util.List;

/*
* 订单实体类
*/
@Data
public class OrderInfo {

  private int id;
  private String orderNumber;
  private String pulishTime;
  private int userId;//用户id
  private int staffId;
  private int serviceId;
  private String frequency;//服务频次
  private String startTime;
  private String endTime;
  private int companyId;//公司id
  private int companyOrderStateId;
  private int userOrderStateId;
  private String title;//标题
  private String description;//要求描述
  private String phone;//电话
  private String money;

  private String userName;
  private String staffName;
  private String typeName;
  private String comName;
  private String stateComName;
  private String orderStateName;


  private String detailAddress;//用户详细地址
  private int detailAddressId;//用户地址id


  private String oneDay;//统计日期
  private int countNum;//统计数量
  private List<String> rowList;//柱状图行 list
  private List<String> colList;//柱状图行 list

}
