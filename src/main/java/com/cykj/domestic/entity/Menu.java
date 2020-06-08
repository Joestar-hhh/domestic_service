package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class Menu {
    private String id;
    private String title;
    private String type;
    private String icon;
    private String openType;
    private String href;

    private String parentId;
    private String parentName;
//    private String menuName;
//    private String menuPath;
}
