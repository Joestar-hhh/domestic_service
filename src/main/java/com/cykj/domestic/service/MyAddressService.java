package com.cykj.domestic.service;


import com.cykj.domestic.entity.MyAddress;
import com.cykj.domestic.util.ResultData;

public interface MyAddressService {
    ResultData selectList(MyAddress myAddress, int page, int pageSize,int userAddressId);
    ResultData addAddress(MyAddress myAddress);
    ResultData updateAddress(MyAddress myAddress);
    ResultData deleteAddress(int id);
    ResultData updateDefultAddress(int userid,int id);

}