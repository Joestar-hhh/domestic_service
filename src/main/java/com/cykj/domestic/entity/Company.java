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
    private String companyProfile;
    private int regionId;
    private int regioncount;
    private String region;

}
