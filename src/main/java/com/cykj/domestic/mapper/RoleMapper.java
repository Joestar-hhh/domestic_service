package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> queryRole(@Param("e") Role role, @Param("start")int start, @Param("pageSize")int pageSize);
    int queryRoleCount(@Param("e") Role role);
}
