package com.cykj.domestic.service;

import com.cykj.domestic.entity.MenuData;
import org.springframework.stereotype.Service;

import java.util.List;

public interface MenuService {

    List<MenuData> queryList();
}
