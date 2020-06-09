package com.cykj.domestic.util;

import com.cykj.domestic.entity.Menu;

import java.util.ArrayList;
import java.util.List;

public class TreeUtil {

//    public static List<MenuVo> toTree(List<MenuVo> treeList, Long pid) {
//        List<MenuVo> retList = new ArrayList<MenuVo>();
//        for (MenuVo parent : treeList) {
//            if (pid.equals(parent.getPid())) {
//                retList.add(findChildren(parent, treeList));
//            }
//        }
//        return retList;
//    }
//    private static MenuVo findChildren(MenuVo parent, List<MenuVo> treeList) {
//        for (MenuVo child : treeList) {
//            if (parent.getId().equals(child.getPid())) {
//                if (parent.getChild() == null) {
//                    parent.setChild(new ArrayList<>());
//                }
//                parent.getChild().add(findChildren(child, treeList));
//            }
//        }
//        return parent;
//    }

    public static List<Menu> toTree(List<Menu> treeList, int pid) {
        List<Menu> retList = new ArrayList<Menu>();
        for (Menu parent : treeList) {
            if (pid == parent.getParentId()) {
                retList.add(findChildren(parent, treeList));
            }
        }
        return retList;
    }

    private static Menu findChildren(Menu parent, List<Menu> treeList) {
        for (Menu child : treeList) {
            if (parent.getId()==child.getParentId()) {
                if (parent.getChildren() == null) {
                    parent.setChildren(new ArrayList<>());
                }
                parent.getChildren().add(findChildren(child, treeList));
            }
        }
        return parent;
    }
}
