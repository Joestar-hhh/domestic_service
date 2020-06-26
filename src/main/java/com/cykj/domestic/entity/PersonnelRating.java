package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class PersonnelRating {
    private int id;
    private String tag;//标签
    private String evaluationContent;//评价
    private String evaluationLevel;//等级
    private String companyName;//所属公司
    private String address;
    private String userName;
    private String skill;
    private String jobState;
}
