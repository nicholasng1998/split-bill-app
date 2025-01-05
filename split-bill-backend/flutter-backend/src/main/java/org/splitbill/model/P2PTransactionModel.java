package org.splitbill.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class P2PTransactionModel {

    private int p2pTransactionId;
    private int userId;
    private int merchantId;
    private BigDecimal lendAmount;
    private BigDecimal paidAmount;
    private String status;
    private Date settlementDate;
}
