package org.splitbill.feign;

import org.splitbill.model.CommonResponseModel;
import org.splitbill.model.P2PTransactionModel;
import org.splitbill.model.TransactionHistoryModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(name = "P2P-TRANSACTION", url = "http://localhost:8081", path = "/v1/p2p-transaction")
public interface P2PTransactionFeignService {

    @PostMapping(value = "/create")
    CommonResponseModel create(@RequestBody P2PTransactionModel p2PTransactionModel);

}
