package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.P2PTransactionBean;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface P2PTransactionRepository extends JpaRepository<P2PTransactionBean, Integer> {

    // Find all transactions by userId
    List<P2PTransactionBean> findByUserId(int userId);

    // Find all transactions by merchantId
    List<P2PTransactionBean> findByMerchantId(int merchantId);

    // Find transactions by status
    List<P2PTransactionBean> findByStatus(String status);

    // Find transactions with a specific lend amount greater than a given value
    List<P2PTransactionBean> findByLendAmountGreaterThan(BigDecimal amount);

    // Find transactions with a specific paid amount greater than a given value
    List<P2PTransactionBean> findByPaidAmountGreaterThan(BigDecimal amount);

    // Find transactions by userId and merchantId
    List<P2PTransactionBean> findByUserIdAndMerchantId(int userId, int merchantId);

    // Find transactions by settlement date
    List<P2PTransactionBean> findBySettlementDate(Date settlementDate);

    // Find transactions by userId and status
    Optional<P2PTransactionBean> findByUserIdAndStatus(int userId, String status);

    // Find transactions by status and settlement date
    List<P2PTransactionBean> findByStatusAndSettlementDate(String status, Date settlementDate);

}
