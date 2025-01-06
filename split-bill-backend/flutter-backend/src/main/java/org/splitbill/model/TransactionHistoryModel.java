package org.splitbill.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class TransactionHistoryModel {
    private int transactionId;
    private int userId;
    private String transactionType;
    private Date transactionDate;
    private BigDecimal transactionAmount;
    private int groupId;
    private String userIdName;
}
