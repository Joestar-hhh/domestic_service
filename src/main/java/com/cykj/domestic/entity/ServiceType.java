package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class ServiceType {
    private int id;//列别表id
    private int companyId;/*公司表id*/
    private String typeName;//类别名字
    private String description;//描述
    private String updateTime;//申请时间
    private String state;//公司端申请服务类别状态
    private String companyName;//公司名称

}
