package splitbill.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "P2P_TRANSACTION")
public class P2PTransactionBean extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "P2P_TRANSACTION_ID")
    private int p2pTransactionId;

    @Column(name = "USER_ID")
    private int userId;

    @Column(name = "MERCHANT_ID")
    private int merchantId;

    @Column(name = "LEND_AMOUNT")
    private BigDecimal lendAmount;

    @Column(name = "PAID_AMOUNT")
    private BigDecimal paidAmount;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "SETTLEMENT_DATE")
    private Date settlementDate;

}
