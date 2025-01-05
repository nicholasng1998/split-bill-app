package splitbill.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.math.BigDecimal;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "P2P_SETUP")
public class P2PSetupBean extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "P2P_SETUP_ID")
    private int p2pSetupId;

    @Column(name = "USER_ID")
    private int userId;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "LEND_AMOUNT")
    private BigDecimal lendAmount;

    @Column(name = "REMAINING_AMOUNT")
    private BigDecimal remainingAmount;

}
