package com.cykj.domestic.entity;

import lombok.Data;

import javax.print.attribute.standard.JobState;

@Data
public class Staff {

    private int id;
    private String account;
    private String userName;
    private String pwd;
    private String phone;
    private String sex;
    private String address;
    private String companyId;
    private String skill;
    private String workage;
    private String nativeplace;
    private String education;
    private String marriage;
    private String state;
    private String idcard;
    private String serviceRelationId;
    private String inductionTime;
    private String avatar;
    private String materialRelationId;
    private int orderNum;
    private String name;// 职位名
    private int regionId;
    private String position;
    private int counselorId;

    private int age;
    private String birthDate;//出生日期
    private String jobState;//工作状态
}
