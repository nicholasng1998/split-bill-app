package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.model.TransactionHistoryModel;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TransactionHistoryServiceImpl implements TransactionHistoryService{

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void makePayment(TransactionHistoryModel transactionHistoryModel) {

    }

    @Override
    @Transactional(readOnly = true)
    public List<TransactionHistoryModel> readTransactionHistory() {
        return null;
    }
}
