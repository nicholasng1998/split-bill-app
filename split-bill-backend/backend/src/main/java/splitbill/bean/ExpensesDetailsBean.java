package splitbill.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.math.BigDecimal;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "EXPENSES_DETAILS")
public class ExpensesDetailsBean extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DETAILS_ID")
    private int detailsId;

    @Column(name = "AMOUNT")
    private BigDecimal amount;

    @Column(name = "ITEM_NAME")
    private String itemName;

    @Column(name = "CREATED_BY")
    private int createdBy;

    @Column(name = "GROUP_ID")
    private int groupId;

}
