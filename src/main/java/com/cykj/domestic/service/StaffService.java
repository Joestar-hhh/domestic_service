package com.cykj.domestic.service;

import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.util.ResultData;

public interface StaffService {

    ResultData queryStaffList(Staff staff, int page, int limit);

}
