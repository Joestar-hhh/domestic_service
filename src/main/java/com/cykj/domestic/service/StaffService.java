package com.cykj.domestic.service;

import com.cykj.domestic.entity.Region;
import com.cykj.domestic.entity.Staff;
import com.cykj.domestic.util.ResultData;

import java.util.List;

public interface StaffService {

    ResultData queryStaffList(Staff staff, int page, int limit ,String region);

    int enableState(int id);

    int disableState(int id);

    List<Staff> checkStaff(int id);

    ResultData regionList();

//    ResultData queryRegion(Staff staff, int page, int limit, String region);
}
