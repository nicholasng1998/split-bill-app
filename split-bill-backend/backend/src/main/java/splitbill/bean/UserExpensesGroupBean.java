package splitbill.bean;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.ToString;

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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "GROUP_ID", insertable = false, updatable = false)
    @JsonIgnoreProperties("expensesGroupBean")
    @ToString.Exclude
    private ExpensesGroupBean expensesGroupBean;

}
