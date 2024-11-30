package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.BankAccountDetailsBean;

import java.util.List;
import java.util.Optional;

@Repository
public interface BankAccountDetailsRepository extends JpaRepository<BankAccountDetailsBean, Integer> {

    // Custom query to find a BankAccountDetailsBean by userId
    Optional<BankAccountDetailsBean> findByUserId(String userId);

    // Custom query to find all BankAccountDetailsBeans by bankName
    List<BankAccountDetailsBean> findByBankName(String bankName);

    // Custom query to find BankAccountDetailsBean by bankAccountNumber
    Optional<BankAccountDetailsBean> findByBankAccountNumber(String bankAccountNumber);

}
