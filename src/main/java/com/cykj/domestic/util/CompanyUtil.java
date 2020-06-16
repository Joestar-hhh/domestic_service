package com.cykj.domestic.util;

import com.cykj.domestic.entity.Company;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CompanyUtil {
    public static String getAccount(String maxAcc,String companyAccount){

        String companyAcc = companyAccount;
        String date = new SimpleDateFormat("yyyyMM").format(new Date());
        date = date.substring(2,date.length());
        String num = "";
        if(maxAcc==null||maxAcc.isEmpty()){
            num = "0001";
        }else{
            num = maxAcc.substring(9,maxAcc.length());
            num = num.format("%04d",Integer.parseInt(num)+1);
        }
        System.out.println("date:"+date);
        System.out.println("num:"+num);
        System.out.println("账号："+companyAcc+date+num);
        return companyAcc+date+num;
    }
}
