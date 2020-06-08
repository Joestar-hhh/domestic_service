package com.cykj.domestic.service.impl;

import com.cykj.domestic.entity.Map;
import com.cykj.domestic.mapper.MapMapper;
import com.cykj.domestic.service.MapSevice;
import com.cykj.domestic.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class MapImpl implements MapSevice {
    @Autowired
    private MapMapper mapMapper;


    @Override
    public HashMap<String, ArrayList<Map>> querymap() {
        ArrayList<Map> Maplist =mapMapper.querymap();
        HashMap<String, ArrayList<Map>> hashMap = new HashMap<String,ArrayList<Map>>();
        System.out.println(Maplist.size());
        for (int i = 0; i < Maplist.size(); i++) {
            Map map = Maplist.get(i);
            System.out.println(map);
            if (hashMap.containsKey(map.getFirstLevelRegion())==false) {
                ArrayList<Map> list = new ArrayList<Map>();
                list.add(map);
                hashMap.put(map.getFirstLevelRegion(), list);
            } else {
                ArrayList<Map> list = hashMap.get(map.getFirstLevelRegion());
                list.add(map);
            }
        }
        return hashMap;
    }

//    查找所有父级地区
    @Override
    public ResultData queryfirstLevelRegion() {
        List<Map> list=mapMapper.queryfirstLevelRegion();
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }
    //    查找次一级地区
    @Override
    public ResultData querySecondaryZone(String id) {
        List<Map> list=mapMapper.querySecondaryZone(id);
        ResultData resultData = new ResultData();
        resultData.setCode(0);
        resultData.setMsg("");
        resultData.setData(list);
        return resultData;
    }
}
