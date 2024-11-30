package splitbill.bean;

import lombok.Data;

import javax.persistence.*;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "USER_SETTING")
public class UserSettingBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SETTING_ID")
    private int settingId;

    @Column(name = "IS_ENABLED_P2P")
    private String isEnabledP2P;

    @Column(name = "MAX_LEND_AMOUNT")
    private BigDecimal maxLendAmount;

    @Column(name = "USER_ID")
    private int userId;
}
