package com.cykj.domestic.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class TbService {

  private int id;
  private String typeName;
  private String description;//服务描述
  private int serviceTypeId;//服务表id
  private String updateTime;
  private String path;
  private int orderNum;//服务单数
  private int unitPrice;//单价
  private String stypeName;//热门服务所属服务类型
  private String serviceCategory;//服务列表所属服务类型
  private String serviceTypeName;//服务类别名
  private int companyId;//公司id
  private String icon;

  private String sName;
  private int stId;
  private String stName;

  private int serviceId;
  private int staffId;

  private BigDecimal levelNum; //好评率

  private String price;//单价
  private String unit;//单位
  private String deposit;//定金
  private String companyName;

  public TbService(){
    if(this.levelNum==null){
      this.levelNum = new BigDecimal(0);
    }
  }

}
