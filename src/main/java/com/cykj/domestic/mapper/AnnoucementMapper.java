package com.cykj.domestic.mapper;


import com.cykj.domestic.entity.Annoucement;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AnnoucementMapper {

    List<Annoucement>queryAnnoucement(@Param("e")Annoucement annoucement,@Param("start")int start,@Param("pageSize") int pageSize);

    int queryAnnoucementCount(@Param("e")Annoucement annoucement);
}
