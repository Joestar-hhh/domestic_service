package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class Map {

  private int id;
  private int parentId;
  private String areaName;
  private String firstLevelRegion ;// 一级地区
  private String secondaryZone;// 二级区域


}
