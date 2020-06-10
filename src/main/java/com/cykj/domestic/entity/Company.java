package com.cykj.domestic.entity;

import lombok.Data;

import java.util.List;

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
    private String companyProfile;
    private int regionId;
    private int regioncount;
    private String region;  //区域名称
    private String typeName;   //公司服务类别

    private int countNum;//统计数量
    private List<String> rowList;//柱状图行 list
    private List<String> colList;//柱状图行 list

}
