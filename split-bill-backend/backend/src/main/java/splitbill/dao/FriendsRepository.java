package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import splitbill.bean.FriendsBean;

import java.util.List;

@Repository
public interface FriendsRepository extends JpaRepository<FriendsBean, Integer> {

    @Query("SELECT f FROM FriendsBean f WHERE f.id.userId IN :userIds")
    List<FriendsBean> findAllByUserId(@Param("userIds") List<Integer> userIds);

    @Query(value = "SELECT * from friends where user_id = :userId and friend_user_id = :friendUserId", nativeQuery = true)
    FriendsBean findByUserIdAndFriendUserId(@Param("userId") int userId, @Param("friendUserId") int friendUserId);

}
