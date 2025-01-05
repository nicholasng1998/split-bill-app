package splitbill.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import splitbill.model.P2PTransactionModel;

@Slf4j
@Service
@RequiredArgsConstructor
public class P2PTransactionServiceImpl implements P2PTransactionService{

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createTransaction(P2PTransactionModel p2PTransactionModel) {

    }
}
