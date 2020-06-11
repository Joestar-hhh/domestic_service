package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Menu;
import com.cykj.domestic.entity.RoleMenu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface MenuMapper {

    List<Menu> queryList(String roleId);

    int insertRoleMenu(List<RoleMenu> list, @Param("roleId") String roleId);
    int deleteRoleMenu(String roleId);
}
