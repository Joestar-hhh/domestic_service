package com.cykj.domestic.entity;

import lombok.Data;

import java.util.List;

@Data
public class TrainPlan {

    private int id;
    private String title;
    private String content;
    private String peopleNum;
    private String startTime;
    private String endTime;
    //  培训统计
    private String oneDay;//统计日期
    private String peoNum;//统计人数
    private int countNum;//统计数量
    private List<String> rowList;//柱状图行 list
    private List<String> colList;//柱状图行 list
    private List<String> peoList;//柱状图行 list

    private int staffId;//员工id
    private int companyId;//公司id




}
