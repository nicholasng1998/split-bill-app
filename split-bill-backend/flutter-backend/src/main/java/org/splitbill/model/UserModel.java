package org.splitbill.model;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class UserModel {
    private int userId;
    private String name;
    private String identityNo;
    private String mobileNo;
    private String username;
    private String password;
    private String bankAccountNumber;
    private String bankName;
    private BigDecimal totalOweAmount;

}
