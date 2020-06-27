package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class ServiceEvaluation {

    private int id;
    private String evaluationContent;
    private String evaluationLevel;
    private int userId;
    private String time;
    private String startTime;
    private String endTime;
    private int companyId;
    private String name;
    private String content;
    private String contentTime;
    private String orderId;
    private String serviceId;

    private String avatar;
    private String userName;
    private String typeName;

}
