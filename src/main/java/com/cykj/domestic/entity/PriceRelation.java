package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class PriceRelation {

  private int id;
  private int serviceId;
  private int companyId;
  private int price;
  private String unit;
  private String deposit;

}
