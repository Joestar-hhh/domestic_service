package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface RoleMapper {

    List<Role> queryRole(@Param("e") Role role, @Param("start")int start, @Param("pageSize")int pageSize);
    int queryRoleCount(@Param("e") Role role);

    int insertRole(Role role);

    int updateRole(Role role);

    int deleteRole(List<String> list);
}
