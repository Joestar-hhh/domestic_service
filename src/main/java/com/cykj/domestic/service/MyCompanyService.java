package com.cykj.domestic.service;


import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

public interface MyCompanyService {

    ResultData selectList(Company company,int userId);
    ResultData updateMycompany(Company company);



}
