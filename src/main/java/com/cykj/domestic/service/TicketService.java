package com.cykj.domestic.service;


import com.cykj.domestic.entity.TbService;
import com.cykj.domestic.entity.Ticket;
import com.cykj.domestic.util.ResultData;

public interface TicketService {
    ResultData selectList(Ticket ticket, int page, int pageSize);

    ResultData addServicelist(Ticket ticket);

    ResultData updateServiceList(Ticket ticket);

    ResultData deleteServiceList(int id);


}
