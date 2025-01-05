package org.splitbill.model;

import lombok.Data;

import java.util.Date;

@Data
public class ActivityModel {

    private int activityId;
    private int userId;
    private String activityType;
    private String action;
    private Date createdDate;
    private Date updatedDate;
}
