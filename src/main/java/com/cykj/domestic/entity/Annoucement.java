package com.cykj.domestic.entity;

import lombok.Data;
/*
  家政管理端的公告管理实体类
 */
@Data
public class Annoucement {

  private int id;
  private java.sql.Timestamp time;
  private String title;
  private String content;


}
