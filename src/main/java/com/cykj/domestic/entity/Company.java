package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class Company {

    private int id;
    private String account;
    private String pwd;
    private String companyName;
    private String boss;
    private String address;
    private String phone;
    private String serviceRelationId;
    private String state;
    private String joinTime;
    private String materialRelationId;
    private String companyProfile;//描述
    private int regionId;//区域id
    private int regioncount;
    private String region;  //区域名称
    private String typeName;   //公司服务类别
    private int roleId;//角色id
    private int countNum;//统计数量
    private String joinDay;
    private int serviceTypeId;
    private  int userId;
    private String firstLevelRegion;//
    private String secondaryZone;
    private String regionName;

}
