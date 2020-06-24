package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class MyAddress {
    private int id;
    private String name;
    private String region;
    private String sex;
    private String age;
    private String phone;
    private String detailAddress;
    private String firstLevelRegion;
    private String secondaryZone;
    private String regionName;
    private int userAddressId;
    private int userId;

}
