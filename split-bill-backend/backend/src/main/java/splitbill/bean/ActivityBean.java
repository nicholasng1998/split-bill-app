package splitbill.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "ACTIVITY")
public class ActivityBean extends Auditable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ACTIVITY_ID")
    private int activityId;

    @Column(name = "USER_ID")
    private int userId;

    @Column(name = "ACTIVITY_TYPE")
    private String activityType;

    @Column(name = "ACTION")
    private String action;
}
