package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class TbService {

  private int id;
  private String typeName;
  private String description;
  private int serviceTypeId;
  private String updateTime;
  private String path;
  private int orderNum;
  private int unitPrice;
  private String serviceCategory;
}
