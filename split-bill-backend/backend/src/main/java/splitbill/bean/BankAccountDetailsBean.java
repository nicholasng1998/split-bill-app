package splitbill.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "BANK_ACCOUNT_DETAILS")
public class BankAccountDetailsBean extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BANK_ACCOUNT_ID")
    private int bankAccountId;

    @Column(name = "BANK_ACCOUNT_NUMBER")
    private String bankAccountNumber;

    @Column(name = "BANK_NAME")
    private String bankName;

    @Column(name = "USER_ID")
    private int userId;
}
