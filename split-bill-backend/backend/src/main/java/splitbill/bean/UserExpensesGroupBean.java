package splitbill.bean;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "USER_EXPENSES_GROUP")
public class UserExpensesGroupBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @Column(name = "USER_ID")
    private int userId;

    @Column(name = "GROUP_ID")
    private int groupId;

    @Column(name = "JOIN_DATE")
    private Date joinDate;

}
