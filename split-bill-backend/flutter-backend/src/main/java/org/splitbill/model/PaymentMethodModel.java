package org.splitbill.model;

import lombok.Data;

@Data
public class PaymentMethodModel {
    private int methodId;
    private String methodName;
    private String cardNumber;
    private String accountNo;
    private int userId;
}
