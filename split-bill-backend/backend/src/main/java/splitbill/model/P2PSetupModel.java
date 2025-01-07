package splitbill.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class P2PSetupModel {

    private int p2pSetupId;
    private int userId;
    private String status;
    private BigDecimal lendAmount;
    private BigDecimal remainingAmount;

    private Date createdDate;

    private Date updatedDate;

    private String userIdName;
}
