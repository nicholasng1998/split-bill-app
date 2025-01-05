package splitbill.service;

import splitbill.model.TransactionHistoryModel;

import java.util.List;

public interface TransactionHistoryService {

    void makePayment(TransactionHistoryModel transactionHistoryModel);

    List<TransactionHistoryModel> readTransactionHistory(TransactionHistoryModel transactionHistoryModel);
}
