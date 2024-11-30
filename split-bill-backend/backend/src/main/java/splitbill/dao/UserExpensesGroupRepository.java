package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.UserExpensesGroupBean;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserExpensesGroupRepository extends JpaRepository<UserExpensesGroupBean, Integer> {

    // Custom query to find all records by userId
    List<UserExpensesGroupBean> findByUserId(String userId);

    // Custom query to find all records by groupId
    List<UserExpensesGroupBean> findByGroupId(String groupId);

    // Custom query to find a record by userId and groupId
    Optional<UserExpensesGroupBean> findByUserIdAndGroupId(String userId, String groupId);

    // Custom query to find all records by joinDate
    List<UserExpensesGroupBean> findByJoinDate(String joinDate);

    // You can add more custom methods depending on your requirements
}
