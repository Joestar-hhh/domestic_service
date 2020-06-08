package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Menu;
import com.cykj.domestic.entity.MenuData;
import com.cykj.domestic.mapper.MenuMapper;
import com.cykj.domestic.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<MenuData> queryList() {
        List<Menu> list = menuMapper.queryList();
        System.out.println(" menuList:"+list);
        List<MenuData> menuDataList = new ArrayList<>();
        MenuData menuData = null;
        for(int i = 0;i<list.size();i++){
            System.out.println("menu>>>>>>"+menuData);

            for(int j = 0;j<menuDataList.size();j++){
                if(menuDataList.get(j).getTitle()!=list.get(i).getParentName()){
                    menuData = new MenuData();
                    menuData.setId(list.get(i).getParentId());
                    menuData.setTitle(list.get(i).getParentName());
                    List<Menu> secondlist = new ArrayList<>();
                    secondlist.add(list.get(i));
                    menuData.setChildren(secondlist);
                    menuDataList.add(menuData);
                }else {
                    List<Menu> secondlist = menuDataList.get(j).getChildren();
                    secondlist.add(list.get(i));
                }
            }

//            if(menuData!=null && menuData.getTitle()==list.get(i).getParentName()){
//                List<Menu> secondlist = menuData.getChildren();
//                secondlist.add(list.get(i));
////                menuData = null;
//            }else{
//                menuData = new MenuData();
//                menuData.setId(list.get(i).getParentId());
//                menuData.setTitle(list.get(i).getParentName());
//                List<Menu> secondlist = new ArrayList<>();
//                secondlist.add(list.get(i));
//                menuData.setChildren(secondlist);
//                menuDataList.add(menuData);
//            }
        }
        System.out.println(" 存入--："+ JSON.toJSONString(menuDataList));
        return null;
    }
}
