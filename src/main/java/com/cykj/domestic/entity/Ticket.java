package com.cykj.domestic.entity;

import lombok.Data;

@Data
public class Ticket {
    private int id;
    private String ticketName;
    private String preferentialNum;
    private String details;
    private String num;
    private String startTime;
    private String endTime;
    private String state;
    private int ticketId;
}
