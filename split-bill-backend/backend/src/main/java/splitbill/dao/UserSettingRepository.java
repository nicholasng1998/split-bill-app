package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.UserSettingBean;

import java.util.Optional;

@Repository
public interface UserSettingRepository extends JpaRepository<UserSettingBean, Integer> {

    // Custom query to find a setting by userId
    Optional<UserSettingBean> findByUserId(String userId);

    // Custom query to find a setting by isEnabledP2P
    Optional<UserSettingBean> findByIsEnabledP2P(String isEnabledP2P);

    // Custom query to find a setting by maxLendAmount
    Optional<UserSettingBean> findByMaxLendAmount(String maxLendAmount);

    // Custom query to find a setting by userId and isEnabledP2P
    Optional<UserSettingBean> findByUserIdAndIsEnabledP2P(String userId, String isEnabledP2P);
}
