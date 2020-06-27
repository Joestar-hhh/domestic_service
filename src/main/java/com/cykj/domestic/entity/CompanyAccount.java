package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class CompanyAccount {
    private int id;
    private String time;
    private String origin;
    private String amountMoney;
    private String optionType;
    private String balance;
    private int companyId;
}
