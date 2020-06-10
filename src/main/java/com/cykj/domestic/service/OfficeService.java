package com.cykj.domestic.service;

import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.util.ResultData;

public interface OfficeService {

    ResultData queryOfficeList(Staff staff, int page, int limit);

    //删除职位
    ResultData deleteOffice(int id);

    //修改职位
    ResultData updateOffice(Staff staff);

    //增加职位
    ResultData insertOffice(Staff staff);

    //下拉框
    ResultData counselorList();
}
