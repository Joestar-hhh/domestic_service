package com.cykj.domestic.service;


import com.cykj.domestic.entity.MyAddress;
import com.cykj.domestic.util.ResultData;

public interface MyAddressService {
    ResultData selectList(MyAddress myAddress,int userid);
    ResultData addAddress(MyAddress myAddress);
    ResultData updateAddress(MyAddress myAddress);
    ResultData deleteAddress(int id);
    ResultData updateDefultAddress(int userid,int id);

//    根据用户地址id查询地址
    ResultData selectUseraddress(MyAddress myAddress);

}
