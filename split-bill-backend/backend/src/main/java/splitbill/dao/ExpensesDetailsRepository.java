package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.ExpensesDetailsBean;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExpensesDetailsRepository extends JpaRepository<ExpensesDetailsBean, Integer> {

    // Custom query to find an expense by its item name
    Optional<ExpensesDetailsBean> findByItemName(String itemName);

    // Custom query to find all expenses by createdBy
    List<ExpensesDetailsBean> findByCreatedBy(String createdBy);

    // Custom query to find all expenses by groupId
    List<ExpensesDetailsBean> findByGroupId(int groupId);

    // Custom query to find an expense by amount
    Optional<ExpensesDetailsBean> findByAmount(String amount);

    // You can add more custom methods depending on your requirements

    // Custom query to find all expenses by groupId
    List<ExpensesDetailsBean> findByGroupIdAndCreatedBy(int groupId, int userId);
}