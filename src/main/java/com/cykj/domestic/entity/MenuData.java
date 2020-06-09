package com.cykj.domestic.entity;

import lombok.Data;

import java.util.List;

@Data
public class MenuData {
    private int id;
    private String title;
    private String type;
    private String icon;
    private String href;
    private String openType;
    private List<MenuData> children;
}
