package splitbill.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class ExpensesGroupModel {

    private int groupId;
    private String groupName;
    private BigDecimal totalExpenses;
    private BigDecimal paidAmount;
    private BigDecimal outstandingAmount;
    private String status;
    private int host;
    private Date dueDate;

}

