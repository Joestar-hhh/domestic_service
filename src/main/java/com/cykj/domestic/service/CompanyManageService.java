package com.cykj.domestic.service;

import com.cykj.domestic.entity.Company;
import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.util.ResultData;

import java.util.List;

public interface CompanyManageService {
    /**
     *家政公司端里列表
     * @param company
     * @param page
     * @param limit
     * @return
     */
    ResultData queryCompany(Company company,int page, int limit,String address);


    /**
     * 审核公司入驻
     * @param company
     * @return
     */
    ResultData checkJoin(Company company);

    /**
     * WX根据服务查询公司列表
     * @param company
     * @param page
     * @param limit
     * @return
     */
    ResultData queryCompanyByService(Company company,int page, int limit,String typeName);


    Company queryCompanyOrderNum(int companyId);
}
