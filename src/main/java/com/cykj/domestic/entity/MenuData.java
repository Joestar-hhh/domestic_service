package com.cykj.domestic.entity;

import lombok.Data;

import java.util.List;

@Data
public class MenuData {
    private String id;
    private String title;
    private String type;
    private String icon;
    private String href;
    private List<Menu> children;

    public MenuData(){
        type = "0";
        icon = "layui-icon layui-icon-console";
    }
}
