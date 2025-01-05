package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import splitbill.bean.FriendsBean;
import splitbill.bean.TransactionHistoryBean;

import java.util.List;
import java.util.Optional;

@Repository
public interface TransactionHistoryRepository extends JpaRepository<TransactionHistoryBean, Integer> {

    // Custom query to find all transactions by userId
    List<TransactionHistoryBean> findByUserId(String userId);

    // Custom query to find transactions by groupId
    List<TransactionHistoryBean> findByGroupId(String groupId);

    // Custom query to find transactions by transactionType
    List<TransactionHistoryBean> findByTransactionType(String transactionType);

    // Custom query to find transactions by transactionDate
    List<TransactionHistoryBean> findByTransactionDate(String transactionDate);

    // Custom query to find a transaction by transactionAmount
    Optional<TransactionHistoryBean> findByTransactionAmount(String transactionAmount);

    // Custom query to find transactions by groupId
    List<TransactionHistoryBean> findAllByUserIdAndGroupId(int userId, int groupId);

    @Query(value = "select * from transaction_history where date(transaction_date) = :transactionDate and group_id = :groupId", nativeQuery = true)
    List<TransactionHistoryBean> findAllByTransactionDateAndGroupId(@Param("transactionDate") String transactionDate, @Param("groupId") int groupId);

}
