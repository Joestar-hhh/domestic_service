package com.cykj.domestic.service;


import com.cykj.domestic.entity.CompanyAccount;
import com.cykj.domestic.entity.Database;
import com.cykj.domestic.util.ResultData;

public interface CompanyAccountService {
    ResultData selectList(CompanyAccount companyAccount, int page, int pageSize, int userid);


    ResultData  selectbalance(CompanyAccount companyAccount, int userid);



}
