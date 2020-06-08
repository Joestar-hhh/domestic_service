package com.cykj.domestic.service;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.util.ResultData;

public interface CompanyManageService {
    /**
     *家政公司端里列表
     * @param company
     * @param page
     * @param limit
     * @return
     */
    ResultData queryCompany(Company company,int page, int limit);


    /**
     * 审核公司入驻
     * @param company
     * @return
     */
    ResultData checkJoin(Company company);
}
