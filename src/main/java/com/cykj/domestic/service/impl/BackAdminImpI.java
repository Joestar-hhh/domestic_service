package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.BackAdmin;
import com.cykj.domestic.mapper.BackAdminMapper;
import com.cykj.domestic.service.BackAdminService;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BackAdminImpI implements BackAdminService {

    @Autowired
    private BackAdminMapper backAdminMapper;


    @Override
    public ResultData backadminLogin(BackAdmin backAdmin) {
        ResultData resultData = new ResultData();
        BackAdmin backAdmin1 = backAdminMapper.backadminLogin(backAdmin);
        if (backAdmin1 != null) {
            if (backAdmin.getPwd().equals(backAdmin1.getPwd())) {
                resultData.setCode(0);
                resultData.setMsg("登入成功");
            } else {
                resultData.setCode(1);
                resultData.setMsg("密码错误");
            }
        } else {
            resultData.setCode(2);
            resultData.setMsg("账号不存在");
        }
        return resultData;
    }
}
