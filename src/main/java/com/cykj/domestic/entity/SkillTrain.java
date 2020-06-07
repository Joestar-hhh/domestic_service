package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class SkillTrain {

  private int id;
  private String trainProjectName;
  private String time;
  private int qualificationId;
  private Qualification qualification;

}
