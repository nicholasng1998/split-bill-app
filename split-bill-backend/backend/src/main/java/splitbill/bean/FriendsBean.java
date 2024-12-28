package splitbill.bean;

import lombok.Data;
import splitbill.bean.embedded.FriendsId;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "FRIENDS")
public class FriendsBean {

    @EmbeddedId
    private FriendsId id;

}
