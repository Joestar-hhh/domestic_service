package com.cykj.domestic.entity;

import lombok.Data;

import java.util.List;

@Data
public class Menu {
    private int id;
    private String title;
    private String type;
    private String icon;
    private String openType;
    private String href;
    private String checked;

    private List<Menu> children;

    private int parentId;
    private String parentName;
    private String menuName;
    private String menuPath;
    private int roleId;

}
