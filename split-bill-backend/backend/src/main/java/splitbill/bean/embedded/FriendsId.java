package splitbill.bean.embedded;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Data
@Embeddable
public class FriendsId implements Serializable {
    @Column(name = "USER_ID")
    private int userId;

    @Column(name = "FRIEND_USER_ID")
    private int friendUserId;
}
