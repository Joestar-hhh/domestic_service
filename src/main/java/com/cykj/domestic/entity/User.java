package com.cykj.domestic.entity;


import lombok.Data;

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
  private String detailAddress;
  private String region;

}
