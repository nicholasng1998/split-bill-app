package splitbill.model;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class ExpensesDetailsModel {

    private int detailsId;
    private BigDecimal amount;
    private String itemName;
    private int createdBy;
    private int groupId;

    private String createdByName;
}
