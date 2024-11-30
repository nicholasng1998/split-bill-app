package splitbill.model;

import lombok.Data;

import java.util.Date;

@Data
public class UserExpensesGroupModel {
    private int id;
    private int userId;
    private int groupId;
    private Date joinDate;
}
