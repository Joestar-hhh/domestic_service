package com.cykj.domestic.service;

import com.cykj.domestic.entity.AfterSalesApplication;
import com.cykj.domestic.util.ResultData;

public interface AfterSalesApplicationService {

    ResultData queryAfterSalesApplication(AfterSalesApplication afterSalesApplication, int page, int limit ,int id,String orderNumber);

    ResultData passCheck(int id);

    ResultData nopassCheck(int id);

    ResultData queryArrangeAfterSales(AfterSalesApplication afterSalesApplication, int page, int limit ,int id,String orderNumber);

    ResultData queryStaffName(int id);

    ResultData arrangeStaff(String staffId,int id);

    ResultData insertSaleApply(AfterSalesApplication afterSalesApplication);

}
