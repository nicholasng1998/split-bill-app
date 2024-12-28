package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.UserBean;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserBean, Integer> {

    List<UserBean> findByUserIdIn(List<Integer> userIds);

    // Custom query to find a user by username
    Optional<UserBean> findByUsername(String username);

    // Custom query to find a user by mobile number
    Optional<UserBean> findByMobileNo(String mobileNo);

    // Custom query to find a user by identity number
    Optional<UserBean> findByIdentityNo(String identityNo);

    // Custom query to find a user by username and password (for login functionality)
    Optional<UserBean> findByUsernameAndPassword(String username, String password);

    // You can add more custom methods depending on your requirements
}
