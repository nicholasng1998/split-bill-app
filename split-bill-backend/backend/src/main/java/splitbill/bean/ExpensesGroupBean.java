package splitbill.bean;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

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

    @OneToMany(mappedBy = "expensesGroupBean", fetch = FetchType.LAZY)
    @JsonIgnoreProperties("userExpensesGroupBeans")
    @ToString.Exclude
    private List<UserExpensesGroupBean> userExpensesGroupBeans;

    public enum STATUS {

        WAITING("waiting"),
        STARTED("started"),
        CLOSED("closed");

        private final String value;

        STATUS(final String value) {
            this.value = value;
        }

        public String toValue() {
            return this.value;
        }
    }
}
