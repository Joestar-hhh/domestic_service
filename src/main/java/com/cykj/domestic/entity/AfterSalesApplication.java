package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class AfterSalesApplication {

  private int id;
  private int userId;
  private int orderInfoId;
  private String reason;
  private String applyTime;
  private String checkState;
  private int staffId;
  private String checkTime;
  private String name;
  private String userName;
  private String orderNumber;
  private String companyId;

}
