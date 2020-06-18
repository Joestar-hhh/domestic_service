package com.cykj.domestic.service;

import com.cykj.domestic.entity.Menu;
import com.cykj.domestic.entity.MenuData;
import com.cykj.domestic.util.ResultData;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

public interface MenuService {

    List<Menu> queryMenuList(String roleId,String projectPath);

    List<Menu> queryList(String roleId);

    ResultData insertRoleMenu(String menuIdList, String roleId);
}
