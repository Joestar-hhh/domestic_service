package com.cykj.domestic.entity;

import lombok.Data;
/*
  家政管理端的公告管理实体类
 */
@Data
public class Annoucement {

  private long id;
  private java.sql.Timestamp time;
  private String title;
  private String content;


  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public java.sql.Timestamp getTime() {
    return time;
  }

  public void setTime(java.sql.Timestamp time) {
    this.time = time;
  }


  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }


  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

}
