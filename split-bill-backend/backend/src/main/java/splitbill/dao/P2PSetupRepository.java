package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.P2PSetupBean;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface P2PSetupRepository extends JpaRepository<P2PSetupBean, Integer> {

    // Find by userId
    List<P2PSetupBean> findByUserId(int userId);

    // Find by status
    List<P2PSetupBean> findByStatus(String status);

    // Find by lendAmount greater than a certain value
    List<P2PSetupBean> findByLendAmountGreaterThan(BigDecimal amount);

    // Find by userId and status
    Optional<P2PSetupBean> findByUserIdAndStatus(int userId, String status);

}
