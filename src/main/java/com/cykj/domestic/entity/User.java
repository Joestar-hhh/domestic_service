package com.cykj.domestic.entity;


import lombok.Data;

import java.util.List;

@Data
public class User {

  private int id;
  private String account;
  private String name;
  private String pwd;
  private String phone;
  private String sex;
  private int age;
  private int userAddressId;
  private String status;
  private String createTime;
  private String detailAddress;//默认地址
  private String region;
  private String oneDay;//统计日期
  private int countNum;//统计数量
  private List<String> rowList;//柱状图行 list
  private List<String> colList;//柱状图行 list


  private String openId;
  private String newLoginTime;//登录时间
  private String avatar;//头像

}
