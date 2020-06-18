package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class Database {
    private int id;
    private String materialName;
    private String num;
    private String res;//凭证地址
    private String dressid;
    private int materialId;
    private String licenseAddress;

}
