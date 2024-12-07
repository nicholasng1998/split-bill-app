package org.splitbill.model;

import lombok.Data;

@Data
public class BankAccountDetailsModel {
    private int bankAccountId;
    private String bankAccountNumber;
    private String bankName;
    private int userId;
}
