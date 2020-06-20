package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class UserClock {

  private int id;
  private String clockTime;
  private int integral;
  private int continuousSign;
  private int userId;

}
