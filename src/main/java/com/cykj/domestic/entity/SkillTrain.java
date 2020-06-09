package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class SkillTrain {

  private int id;
  private String trainProjectName;
  private String time;
  private int qualificationId;
  private Qualification qualification;
  private String picturePath;//图片路径
  private String type;//类别
  private String path;//培训风采图片视频路径


}
