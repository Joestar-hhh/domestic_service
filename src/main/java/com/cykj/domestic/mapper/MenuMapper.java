package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.Menu;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface MenuMapper {

    List<Menu> queryList();
}
