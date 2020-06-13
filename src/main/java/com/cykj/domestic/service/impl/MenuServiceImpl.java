package com.cykj.domestic.service.impl;

import com.alibaba.fastjson.JSON;
import com.cykj.domestic.entity.Menu;
import com.cykj.domestic.entity.MenuData;
import com.cykj.domestic.entity.RoleMenu;
import com.cykj.domestic.mapper.MenuMapper;
import com.cykj.domestic.service.MenuService;
import com.cykj.domestic.util.ResultData;
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
    public List<Menu> queryList(String roleId) {
        List<Menu> tablist = menuMapper.queryList(roleId);
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
        List<Menu> menuList = TreeUtil.toTree(mList, 0);

        TreeUtil.checkedMenu(menuList);

        System.out.println(">>>>>>>>>>>>>>>menuList:"+JSON.toJSONString(menuList));
        return menuList;
    }

    @Override
    public ResultData insertRoleMenu(String rolemenuList, String roleId) {
        List<RoleMenu> list = JSON.parseArray(rolemenuList,RoleMenu.class);
        int res = menuMapper.deleteRoleMenu(roleId);
        if(list.size()>0){
            res = menuMapper.insertRoleMenu(list,roleId);
        }
        ResultData resultData = new ResultData();
        if (res >= 1) {
            resultData.setCode(0);
            resultData.setMsg("菜单保存成功");
        } else {
            resultData.setCode(1);
            resultData.setMsg("保存失败");
        }
        return resultData;
    }
}
