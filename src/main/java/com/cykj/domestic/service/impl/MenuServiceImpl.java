package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Menu;
import com.cykj.domestic.entity.MenuData;
import com.cykj.domestic.mapper.MenuMapper;
import com.cykj.domestic.service.MenuService;
import com.cykj.domestic.util.TreeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Menu> queryList() {
        List<Menu> tablist = menuMapper.queryList();
//        System.out.println(" menuList:"+tablist);

        List<Menu> mList = new ArrayList<>();
        for(Menu menu : tablist){
            menu.setId(menu.getId());
            menu.setTitle(menu.getMenuName());
            menu.setType("0");
            menu.setHref(menu.getMenuPath());
            if(menu.getParentId()!=0){
                menu.setType("1");
                menu.setOpenType("_iframe");
            }
            mList.add(menu);
        }
//        System.out.println(" 存入--："+ JSON.toJSONString(mList));
        List<Menu> menuList = TreeUtil.toTree(mList, 0);

        return menuList;
    }



//    public List<Menu> toTree(List<Menu> treeList, int pid) {
//        List<Menu> retList = new ArrayList<Menu>();
//        for (Menu parent : treeList) {
//            if (pid == parent.getParentId()) {
//                retList.add(findChildren(parent, treeList));
//            }
//        }
//        return retList;
//    }
//
//    private Menu findChildren(Menu parent, List<Menu> treeList) {
//        for (Menu child : treeList) {
//            if (parent.getId()==child.getParentId()) {
//                if (parent.getChildren() == null) {
//                    parent.setChildren(new ArrayList<>());
//                }
//                parent.getChildren().add(findChildren(child, treeList));
//            }
//        }
//        return parent;
//    }
}
