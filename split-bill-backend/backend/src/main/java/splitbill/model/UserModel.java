package splitbill.model;

import lombok.Data;

@Data
public class UserModel {
    private int userId;
    private String identityNo;
    private String mobileNo;
    private String username;
    private String password;
    private String bankAccountNumber;
    private String bankName;

}
