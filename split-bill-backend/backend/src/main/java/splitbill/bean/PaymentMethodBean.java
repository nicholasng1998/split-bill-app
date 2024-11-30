package splitbill.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "PAYMENT_METHOD")
public class PaymentMethodBean extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "METHOD_ID")
    private int methodId;

    @Column(name = "METHOD_NAME")
    private String methodName;

    @Column(name = "CARD_NUMBER")
    private String cardNumber;

    @Column(name = "ACCOUNT_NO")
    private String accountNo;

    @Column(name = "USER_ID")
    private int userId;
}
