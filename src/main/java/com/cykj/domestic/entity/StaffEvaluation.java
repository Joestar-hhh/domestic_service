package com.cykj.domestic.entity;
import lombok.Data;

@Data
public class StaffEvaluation {

  private int id;
  private String tag;
  private String evaluationContent;
  private String evaluationLevel;
  private int orderId;
  private String staffLevel;//人员评价星级别名


}
