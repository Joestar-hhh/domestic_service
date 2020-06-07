package com.cykj.domestic.entity;


public class TbSkillTrain {

  private long id;
  private String trainProjectName;
  private String time;
  private long qualificationId;
  private TbQualification tbQualification;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getTrainProjectName() {
    return trainProjectName;
  }

  public void setTrainProjectName(String trainProjectName) {
    this.trainProjectName = trainProjectName;
  }

  public String getTime() {
    return time;
  }

  public void setTime(String time) {
    this.time = time;
  }

  public long getQualificationId() {
    return qualificationId;
  }

  public void setQualificationId(long qualificationId) {
    this.qualificationId = qualificationId;
  }

  public TbQualification getTbQualification() {
    return tbQualification;
  }

  public void setTbQualification(TbQualification tbQualification) {
    this.tbQualification = tbQualification;
  }
}
