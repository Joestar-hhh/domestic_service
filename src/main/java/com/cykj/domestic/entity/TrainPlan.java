package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class TrainPlan {

  private int id;
  private String title;
  private String content;
  private String peopleNum;
  private String startTime;
  private String endTime;

}
