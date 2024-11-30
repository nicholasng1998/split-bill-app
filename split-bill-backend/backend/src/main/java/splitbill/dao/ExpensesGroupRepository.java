package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.ExpensesGroupBean;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExpensesGroupRepository extends JpaRepository<ExpensesGroupBean, Integer> {

    // Custom query to find a group by its group name
    Optional<ExpensesGroupBean> findByGroupName(String groupName);

    // Custom query to find all groups by the host (the user who created the group)
    List<ExpensesGroupBean> findByHost(String host);

    // Custom query to find all groups by their status
    List<ExpensesGroupBean> findByStatus(String status);

    // Custom query to find a group by its due date
    Optional<ExpensesGroupBean> findByDueDate(String dueDate);

    // Custom query to find groups where the outstanding amount is greater than zero
    List<ExpensesGroupBean> findByOutstandingAmountGreaterThan(String outstandingAmount);

    // Custom query to find all groups where total expenses are greater than a specific amount
    List<ExpensesGroupBean> findByTotalExpensesGreaterThan(String totalExpenses);

    // You can add more custom methods depending on your requirements
}
