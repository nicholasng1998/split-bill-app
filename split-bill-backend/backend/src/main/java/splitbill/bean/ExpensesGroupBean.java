package splitbill.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "EXPENSES_GROUP")
public class ExpensesGroupBean extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "GROUP_ID")
    private int groupId;

    @Column(name = "GROUP_NAME")
    private String groupName;

    @Column(name = "TOTAL_EXPENSES")
    private BigDecimal totalExpenses;

    @Column(name = "PAID_AMOUNT")
    private BigDecimal paidAmount;

    @Column(name = "OUTSTANDING_AMOUNT")
    private BigDecimal outstandingAmount;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "HOST")
    private int host;

    @Column(name = "DUE_DATE")
    private Date dueDate;
}
