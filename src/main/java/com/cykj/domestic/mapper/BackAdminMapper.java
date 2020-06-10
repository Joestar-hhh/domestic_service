package com.cykj.domestic.mapper;

import com.cykj.domestic.entity.BackAdmin;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface BackAdminMapper {

    BackAdmin backadminLogin(BackAdmin backAdmin);


}


