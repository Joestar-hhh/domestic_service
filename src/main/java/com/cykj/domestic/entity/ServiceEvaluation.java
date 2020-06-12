package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class ServiceEvaluation {

    private int id;
    private String evaluationContent;
    private String evaluationLevel;
    private int userId;
    private String time;
    private int companyId;

}
