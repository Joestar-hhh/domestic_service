package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class TbService {

  private int id;
  private String typeName;
  private String description;//服务描述
  private int serviceTypeId;//服务表id
  private String updateTime;
  private String path;
  private int orderNum;//服务单数
  private int unitPrice;//单价
  private String stypeName;//热门服务所属服务类型
  private String serviceCategory;//服务列表所属服务类型

}
