package com.cykj.domestic.service;


import com.cykj.domestic.entity.Database;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface DataBaseService {
    ResultData selectList(Database database, int page, int pageSize,int userid);
    ResultData addServicelist(Database database,int userid);
    ResultData serviceListView(Database database,int userid);


    ResultData selectStaff(Database database, int page, int pageSize,int userid);
    ResultData addStafflist(Database database,int userid);
    ResultData StaffListView(Database database,int userid);
}
