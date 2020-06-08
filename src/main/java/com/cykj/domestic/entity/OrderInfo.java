package com.cykj.domestic.entity;

import lombok.Data;

/*
* 订单实体类
*/
@Data
public class OrderInfo {

  private int id;
  private String orderNumber;
  private String pulishTime;
  private int userId;
  private int staffId;
  private int serviceId;
  private String frequency;
  private String startTime;
  private String endTime;
  private int companyId;
  private int companyOrderStateId;
  private int userOrderStateId;
  private String title;
  private String description;
  private String phone;

  private String userName;
  private String staffName;
  private String typeName;
  private String comName;
  private String stateComName;

}
