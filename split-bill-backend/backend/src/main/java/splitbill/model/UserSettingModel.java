package splitbill.model;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class UserSettingModel {
    private int settingId;
    private String isEnabledP2P;
    private BigDecimal maxLendAmount;
    private int userId;
}
