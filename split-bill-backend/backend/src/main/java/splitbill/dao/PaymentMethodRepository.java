package splitbill.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import splitbill.bean.PaymentMethodBean;

import java.util.List;
import java.util.Optional;

@Repository
public interface PaymentMethodRepository extends JpaRepository<PaymentMethodBean, Integer> {

    // Custom query to find a payment method by method name
    Optional<PaymentMethodBean> findByMethodName(String methodName);

    // Custom query to find a payment method by card number
    Optional<PaymentMethodBean> findByCardNumber(String cardNumber);

    // Custom query to find a payment method by account number
    Optional<PaymentMethodBean> findByAccountNo(String accountNo);

    // Custom query to find all payment methods by userId
    List<PaymentMethodBean> findByUserId(String userId);

    // You can add more custom methods depending on your requirements
}
