package com.cykj.domestic.service;

import com.cykj.domestic.entity.BackAdmin;
import com.cykj.domestic.util.ResultData;

public interface BackAdminService {

//    平台端登入
    ResultData backadminLogin(BackAdmin backAdmin);

}
